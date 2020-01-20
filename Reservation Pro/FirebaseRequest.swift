//
//  FirebaseRequest.swift
//  Reservation Pro
//
//  Created by Rahil Patel on 1/20/20.
//  Copyright © 2020 GoJackets. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseRequest {
    let db = Database.database()
    func observe(path: String, callback: @escaping (DataSnapshot) -> ()) {
        let ref = db.reference(withPath: path)
        ref.observeSingleEvent(of: .value) { snapshot in
            callback(snapshot)
        }
    }
    func makeSingleObserver(path: String) {
        
    }
    func uploadData(path: String, value: Any?) {
        let ref = db.reference(withPath: path)
        ref.setValue(value)
    }
}
