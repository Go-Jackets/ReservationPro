//
//  Reservation.swift
//  Reservation Pro
//
//  Created by Rahil Patel on 1/21/20.
//  Copyright © 2020 GoJackets. All rights reserved.
//

import Foundation

struct Reservation: Codable {
    var rID: String
    var dateTime: String
    var numPeople: Int
    var location: String
    var reserverID: String
}
