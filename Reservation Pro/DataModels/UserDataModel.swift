//
//  UserDataModel.swift
//  Reservation Pro
//
//  Created by Rahil Patel on 1/20/20.
//  Copyright © 2020 GoJackets. All rights reserved.
//

import Foundation
import Combine

class UserDataModel: ObservableObject {
    @Published var signedIn: Bool = false
    @Published var user: User?
    
    func getUserData(onFinish: @escaping () -> ()) {
        let req = FirebaseRequest()
        if let user = user {
            let data = [
                "reservations":[],
                "name": user.name
                ] as [String : Any]
            req.observe(path: "/users/\(user.uID)") { (snap) in
                print(snap.exists())
                if !snap.exists() {
                    req.uploadData(path: "/users/\(user.uID)", value: data)
                } else {
                    self.parseUserData(data: snap.value as? [String: Any])
                }
                onFinish()
            }
        }
    }
    private func parseUserData(data: [String: Any]?) {
        guard let data = data else { return }
        guard let name = data["name"] as? String else { return }
        user?.name = name
        if let rIDs = data["reservations"] as? [String] {
            for rID in rIDs {
                getReservation(from: rID)
            }
        }
    }
    private func getReservation(from rID: String) {
        let req = FirebaseRequest()
        req.observe(path: "/reservations/\(rID)") { snap in
            if snap.exists() {
                self.parseReservationData(data: snap.value as? [String: Any], rID: rID)
            }
        }
    }
    private func parseReservationData(data: [String: Any]?, rID: String) {
        guard let data = data else { return }
        guard let dateTime = data["dateTime"] as? String else { return }
        guard let numPeople = data["numPeople"] as? Int else { return }
        guard let location = data["location"] as? String else { return }
        guard let reserverID = user?.uID else { return }
        let reservation = Reservation(rID: rID, dateTime: dateTime, numPeople: numPeople, location: location, reserverID: reserverID)
        guard let user = user else { return }
        let reservationIDs = user.reservations.map { $0.rID }
        if reservationIDs.contains(rID) {
            // update a reservation
            let i = reservationIDs.firstIndex(of: rID)!
            self.user!.reservations[i] = reservation
        } else {
            // create a new reservation
            self.user?.reservations.append(reservation)
        }
    }
    
    func handleReservation(_ reservation: Reservation) {
        let req = FirebaseRequest()
        do {
            let data = try JSONEncoder().encode(reservation)
            let dict = try JSONSerialization.jsonObject(with: data)
            req.uploadData(path: "/reservations/\(reservation.rID)", value: dict)
            guard let user = user else { return }
            let rIDs = user.reservations.map { $0.rID }
            if !rIDs.contains(reservation.rID) {
                self.user?.reservations.append(reservation)
                guard let updatedReservations = self.user?.reservations else { return }
                req.uploadData(path: "/users/\(user.uID)/reservations", value: updatedReservations.map { $0.rID })
            }
        } catch {
            print("There was an issue")
        }
    }
    
    func deleteReservation(at offsets: IndexSet) {
        let reservation = self.user!.reservations.remove(at: offsets.first!)
        guard let user = user else { return }
        let req = FirebaseRequest()
        req.uploadData(path: "/users/\(user.uID)/reservations", value: user.reservations.map { $0.rID })
        req.deleteData(path: "/reservations/\(reservation.rID)")
    }
}
