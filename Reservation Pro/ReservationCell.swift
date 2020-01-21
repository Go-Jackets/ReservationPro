//
//  ReservationCell.swift
//  Reservation Pro
//
//  Created by Rahil Patel on 1/21/20.
//  Copyright © 2020 GoJackets. All rights reserved.
//

import SwiftUI

struct ReservationCell: View {
    var reservation: Reservation
    var body: some View {
        NavigationLink(destination: ReservationView(reservationDate: dateFor(dateStr: reservation.dateTime), selectorIndex: indexFor(locationStr: reservation.location), numPeople: "\(reservation.numPeople)", newReservation: false, rID: reservation.rID)) {
            VStack {
                Text("Reservation for \(reservation.numPeople) \(reservation.numPeople == 1 ? "person" : "people")")
                Text("on \(readableDateString(for: reservation.dateTime))")
                Text("with a preference for \(reservation.location) seating.")
            }.multilineTextAlignment(.leading)
        }
    }
    private func dateFor(dateStr: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = formatter.date(from: dateStr) else { return Date() }
        return date
    }
    private func indexFor(locationStr: String) -> Int {
        switch locationStr {
        case "Inside":
            return 0
        case "Outside":
            return 1
        case "Smoke Free":
            return 2
        default:
            return 0
        }
    }
    private func readableDateString(for dateStr: String) -> String {
        let date = dateFor(dateStr: dateStr)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter.string(from: date)
    }
}

struct ReservationCell_Previews: PreviewProvider {
    static var previews: some View {
        ReservationCell(reservation: Reservation(rID: "", dateTime: "", numPeople: 10, location: "", reserverID: ""))
    }
}
