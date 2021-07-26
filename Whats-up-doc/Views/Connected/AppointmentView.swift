//
//  AppointmentView.swift
//  Whats-up-doc
//
//  Created by Aymeric Larvet on 27/06/2021.
//

import SwiftUI

struct AppointmentView: View {
    @EnvironmentObject private var userData: UserData
    
    var body: some View {
        if userData.isLoggedIn {
            AppointmentLoggedView()
        } else {
            NavigationView {
                AppointmentNotLoggedView()
            }
        }
    }
}
              
//               =======
//         ZStack(alignment: .top) {
//             VStack(spacing: 0) {
//                 Image(systemName: "calendar")
//                     .resizable()
//                     .frame(width: 50, height: 50)
//                     .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//                 Text("Appointments")
//                     .font(.largeTitle)
//                     .shadow(radius: 10.0, x: 20, y: 10)
//                     .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//                 List {
//                     ForEach(appointments) { appointment in
//                         AppointmentRow(appointment: appointment)
//                                }
//                     .listRowBackground(Color.blue
// //                                        .clipped()
// //                                       .cornerRadius(10)
//                                         .opacity(0.7)
//                     )
//                     .opacity(0.7)
//                 }.clipped().cornerRadius(10)
//                     .padding(.horizontal, 10)
//                     .padding(.top, 10)
//                 Button(action: {
//                     openNewAppointmentModal()
//                 }) {
//                     Text("New Appointment")
//                         .textButtonNotDisabled(color: Color.blue)

//                 }.padding(.top, 50)
//                 .padding(.horizontal, 10)
// >>>>>>> feature/account

struct AppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentView()
    }
}
