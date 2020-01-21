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
                    self.userDataModel.user = User(uID: uid, reservationIDs: [], name: name)
                    self.userDataModel.signedIn = true
                    print(uid)
//                    uid = uid
                    self.userDataModel.getUserData()
                }
                NavigationLink(destination: ReservationView(), isActive: $userDataModel.signedIn) {
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

struct TestView: View {
    var body: some View {
        Text("")
    }
}

struct ReservationView: View {
    @State private var reservationDate = Date()
    @State private var selectorIndex = 0
    @State private var locations = ["Inside","Outside","Smoke Free"]
    @State private var numPeople = ""
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }

   var body: some View {
        VStack {
            TextField("Enter amount of people...", text: $numPeople)
            DatePicker(selection: $reservationDate, in: ...Date(), displayedComponents: .date) {
                Text("Select a date")
            }

            Picker("Numbers", selection: $selectorIndex) {
                  ForEach(0 ..< locations.count) { index in
                      Text(self.locations[index]).tag(index)
                  }
              }
              .pickerStyle(SegmentedPickerStyle())
            
            Text("Date is \(reservationDate, formatter: dateFormatter)")
            Text("Selected Location is: \(locations[selectorIndex])").padding()
            Text("The amount of people: \(numPeople)")
//            Text("Reservation Uid: \(user().uID)")
            
            
        }
    }
}
