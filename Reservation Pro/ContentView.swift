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
        VStack {
            GoogleSignInButton(colorScheme: .light) { (uid) in
                self.userDataModel.uid = uid
                print(uid)
            }
            Text(userDataModel.uid ?? "")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
