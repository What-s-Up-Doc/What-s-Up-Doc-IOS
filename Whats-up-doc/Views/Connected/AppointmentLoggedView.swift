//
//  AppointmentLoggedView.swift
//  Whats-up-doc
//
//  Created by Hermance Dornier on 25/07/2021.
//

import SwiftUI

struct AppointmentLoggedView: View {
    var appointments = getAppointments()
    @State private var showingSheet = false

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                
                HeaderComponent()
                
                Section(header: HeaderSectionView(title: "Appointments",icon: "calendar")) {
                    List {
                        ForEach(appointments) { appointment in
                            AppointmentRow(appointment: appointment)
                                   }
                        .listRowBackground(Color.blue
                                            .opacity(0.7)
                        )
                        .opacity(0.7)
                    }.clipped().cornerRadius(10)
                        .padding(.horizontal, 10)
                        .padding(.top, 10)
                }


                Button(action: {
                    showingSheet.toggle()
                }) {
                    Text("New Appointment")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 10.0, x: 20, y: 10)

                }
                .sheet(isPresented: $showingSheet) {
                    AppointmentSheetView()
                }.padding(.top, 50)
                .padding(.bottom, 20)
                .padding(.horizontal, 10)
            }
        }.background(Color.green)
    }
}

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

struct Appointment: Identifiable {
    let id = UUID()
    let date: String
    let status: String
    let doctor: String
    let patient: String
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

struct AppointmentLoggedView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentLoggedView()
    }
}
