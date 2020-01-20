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
        if let id = user?.uID {
            req.observe(path: "/\(id)") { (snap) in
                print(snap.exists())
            }
        }
        
    }
}
