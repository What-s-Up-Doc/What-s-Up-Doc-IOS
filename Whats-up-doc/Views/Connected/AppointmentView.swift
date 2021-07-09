//
//  AppointmentView.swift
//  Whats-up-doc
//
//  Created by Aymeric Larvet on 27/06/2021.
//

import SwiftUI

struct AppointmentView: View {
    var appointments = getAppointments()
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                Image(systemName: "calendar")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                Text("Appointments")
                    .font(.largeTitle)
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                List {
                    ForEach(appointments) { appointment in
                        AppointmentRow(appointment: appointment)
                               }
                    .listRowBackground(Color.blue
//                                        .clipped()
//                                       .cornerRadius(10)
                                        .opacity(0.7)
                    )
                    .opacity(0.7)
                }.clipped().cornerRadius(10)
                    .padding(.horizontal, 10)
                    .padding(.top, 10)
                Button(action: {
                    openNewAppointmentModal()
                }) {
                    Text("New Appointment")
                        .textButtonNotDisabled(color: Color.blue)

                }.padding(.top, 50)
                .padding(.horizontal, 10)
            }
        }
    }
}

struct Appointment: Identifiable {
    let id = UUID()
    let date: String
    let status: String
    let doctor: String
    let patient: String
}

let openNewAppointmentModal = {
    // TODO
}

let getAppointments = {
    return [
        Appointment(date: "12/12/2012",
                    status: "done", doctor: "Dr. Who",
                    patient:"Amy Pond"),
        Appointment(date: "12/12/2021",
                        status: "pending", doctor: "Dr. Who",
                        patient:"Rory Pond"),
        Appointment(date: "12/12/2021",
                        status: "pending", doctor: "Dr. Who",
                        patient:"Rory Pond"),
        Appointment(date: "12/12/2012",
                    status: "done", doctor: "Dr. Who",
                    patient:"Amy Pond"),
        Appointment(date: "12/12/2021",
                        status: "pending", doctor: "Dr. Who",
                        patient:"Rory Pond"),
        Appointment(date: "13/12/2012",
                    status: "other", doctor: "Dr. Who",
                    patient:"Rose"),
        Appointment(date: "13/12/2012",
                    status: "other", doctor: "Dr. Who",
                    patient:"Rose"),
        Appointment(date: "12/12/2012",
                    status: "done", doctor: "Dr. Who",
                    patient:"Amy Pond"),
    ]
}

struct AppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentView()
    }
}

// one appointment view
struct AppointmentRow: View {
    var appointment: Appointment

    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: self.appointment.status == "done" ?
                    "checkmark.seal.fill" : self.appointment.status == "pending" ?
                        "clock" : "questionmark")
                .frame(width: 20, height: 20)
            Text(appointment.date)
                .foregroundColor(.white)
            Text(appointment.doctor)
                .foregroundColor(.white)
                .bold()
            Text(appointment.patient)
                .foregroundColor(.white)
        }
    }
}
