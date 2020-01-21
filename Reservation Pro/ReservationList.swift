//
//  ReservationList.swift
//  Reservation Pro
//
//  Created by Rahil Patel on 1/21/20.
//  Copyright © 2020 GoJackets. All rights reserved.
//

import SwiftUI

struct ReservationList: View {
    @EnvironmentObject var userDataModel: UserDataModel
    @State var navigateNewReservation = false
    var body: some View {
        Group {
            if userDataModel.user!.reservations.count > 0 {
                List {
                    ForEach(userDataModel.user!.reservations, id: \.rID) { reservation in
                        ReservationCell(reservation: reservation)
                    }
                }
            } else {
                Text("You haven't made any reservations yet!")
                Button(action: {
                    self.navigateNewReservation = true
                }) {
                    Text("Create Reservation")
                }
            }
            NavigationLink(destination: ReservationView(reservationDate: Date(), selectorIndex: 0, numPeople: "1", newReservation: true, rID: "\(UUID())"), isActive: $navigateNewReservation) {
                EmptyView()
            }.navigationBarItems(trailing: Button(action: {
                self.navigateNewReservation = true
            }, label: {
                Image(systemName: "plus")
            }))
        }.navigationBarTitle("Reservations")
        .navigationBarBackButtonHidden(true)
        .onAppear {
            self.userDataModel.getUserData {
                print("Updated user data")
            }
        }
    }
}

struct ReservationList_Previews: PreviewProvider {
    static var previews: some View {
        ReservationList()
    }
}
