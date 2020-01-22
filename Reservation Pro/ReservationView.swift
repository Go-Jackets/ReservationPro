//
//  ReservationView.swift
//  Reservation Pro
//
//  Created by Rahil Patel on 1/21/20.
//  Copyright © 2020 GoJackets. All rights reserved.
//

import SwiftUI

struct ReservationView: View {
    @EnvironmentObject var userDataModel: UserDataModel
    @State var reservationDate: Date
    @State var selectorIndex: Int
    @State private var locations = ["Inside","Outside","Smoke Free"]
    @State var numPeople: String
    @State var createdReservation = false
    var newReservation: Bool
    @Environment(\.presentationMode) var presentationMode
    var rID: String
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }

   var body: some View {
        Form {
            Section(footer:
                HStack {
                    Spacer()
                    Button(action: {
                        let reservation = Reservation(rID: self.rID, dateTime: self.getDateString(from: self.reservationDate), numPeople: Int(self.numPeople) ?? 0, location: self.locations[self.selectorIndex], reserverID: self.userDataModel.user?.uID ?? "")
                        self.userDataModel.handleReservation(reservation)
                        self.createdReservation = true
                    }) {
                        Text(newReservation ? "Create" : "Update").accentColor(.black)
                    }.frame(width: 120, height: 40).background(Color("Orange")).cornerRadius(8)
                    Spacer()
                }
            ) {
                HStack {
                    Text("Number of people:")
                    TextField("Enter amount of people", text: $numPeople)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                }
                DatePicker(selection: $reservationDate, in: Date()..., displayedComponents: .date) {
                    Text("Select a date")
                }
                DatePicker(selection: $reservationDate, in: Date()..., displayedComponents: .hourAndMinute) {
                    Text("Select a time")
                }

                Picker("Numbers", selection: $selectorIndex) {
                    ForEach(0 ..< locations.count) { index in
                        Text(self.locations[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .foregroundColor(Color("Orange"))
            }
        }.alert(isPresented: $createdReservation) {
            Alert(title: Text("Success!"), message: Text("Thanks for making a reservation with us!"), dismissButton: .default(Text("OK"), action: {
                self.presentationMode.wrappedValue.dismiss()
            }))
        }.navigationBarTitle(self.newReservation ? "Create Reservation" : "Update Reservation", displayMode: .inline)
        .onTapGesture(count: 2) {
            UIApplication.shared.endEditing()
        }
    }
    
    private func getDateString(from date: Date) -> String {
        print(date)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        print(formatter.string(from: date))
        return formatter.string(from: date)
    }
}


struct ReservationView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView(reservationDate: Date(), selectorIndex: 0, numPeople: "1", newReservation: true, rID: "\(UUID())")
    }
}

extension UIApplication {
    var isKeyboardPresented: Bool {
        if let keyboardWindowClass = NSClassFromString("UIRemoteKeyboardWindow"),
            self.windows.contains(where: { $0.isKind(of: keyboardWindowClass) }) {
            return true
        } else {
            return false
        }
    }
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
