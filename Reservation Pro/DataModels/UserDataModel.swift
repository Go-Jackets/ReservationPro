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
        user?.reservations = []
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
        user?.reservations.append(reservation)
    }
}
