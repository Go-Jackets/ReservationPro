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
        Group {
            GoogleSignInButton(colorScheme: .light) { (uid) in
                self.userDataModel.uid = uid
                self.userDataModel.signedIn = true
                print(uid)
            }
            NavigationLink(destination: TestView(), isActive: $userDataModel.signedIn) {
                EmptyView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TestView: View {
    var body: some View {
        Text("")
    }
}
