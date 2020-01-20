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
    
    func getUserData() {
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
                }
            }
        }
        
    }
}
