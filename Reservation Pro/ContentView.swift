//
//  ContentView.swift
//  Reservation Pro
//
//  Created by Rahil Patel on 1/20/20.
//  Copyright © 2020 GoJackets. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userDataModel: UserDataModel
    
    var body: some View {
        NavigationView {
            VStack {
                GoogleSignInButton(colorScheme: .light) { (uid, name) in
                    self.userDataModel.user = User(uID: uid, reservations: [], name: name)
                    print(uid)
                    self.userDataModel.getUserData {
                        self.userDataModel.signedIn = true
                    }
                }
                NavigationLink(destination: ReservationList().environmentObject(userDataModel), isActive: $userDataModel.signedIn) {
                    EmptyView()
                }
            }
            
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
