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
            NavigationLink(destination: ReservationView(), isActive: $navigateNewReservation) {
                EmptyView()
            }.navigationBarItems(trailing: Button(action: {
                self.navigateNewReservation = true
            }, label: {
                Image(systemName: "plus")
            }))
            }.navigationBarTitle("Reservations")
            .navigationBarBackButtonHidden(true)
    }
}

struct ReservationList_Previews: PreviewProvider {
    static var previews: some View {
        ReservationList()
    }
}
