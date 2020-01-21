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
        Text(reservation.rID)
    }
}

struct ReservationCell_Previews: PreviewProvider {
    static var previews: some View {
        ReservationCell(reservation: Reservation(rID: "", dateTime: "", numPeople: 10, location: "", reserverID: ""))
    }
}
