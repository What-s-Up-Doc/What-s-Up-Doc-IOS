//
//  AppointmentLoggedView.swift
//  Whats-up-doc
//
//  Created by Aymeric Larvet on 25/07/2021.
//

import SwiftUI



struct AppointmentLoggedView: View {

    @State var appointments = getAppointments()
    @State private var showingSheet = false
    @State private var showConfirmCancel = false
    @State private var index: IndexSet?
    
    @State private var isOk: Bool = false
    
    @State var showResponseMessage: Bool = false
    
    @State var messageTitle: String = ""
    @State var messageContent: String = ""
    @State var messageColor: Color = Color.blue
        
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            if showResponseMessage {
                ResponseMessageComponent(title: messageTitle, message: messageContent,color: messageColor)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            self.showResponseMessage = false
                        }
                    }
            }
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    
                    HeaderComponent()
                    
                    Section(header: HeaderSectionView(title: "Appointments",icon: "calendar")) {
                        ZStack(alignment: .bottom){
                            if appointments.count > 0 {
                                List {
                                    ForEach(appointments.reversed()) { appointment in
                                        AppointmentRow(appointment: appointment)
                                    }
                                    .onDelete { (indexSet) in
                                            self.showConfirmCancel = true
                                            self.index = indexSet
                                    }
                                    .listRowBackground(Color("lightGray"))
                                    .opacity(0.7)
                                }.cornerRadius(10)
                                .padding(.top, 10)
                            } else {
                                Text("No appointments")
                                    .padding(.vertical,200)
                            }

                            Button(action: {
                                showingSheet.toggle()
                            }) {
                                
                                HStack(){
                                    Image(systemName: "calendar.badge.plus")
                                    Text("New Appointment")
                                }
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(30)
                                .shadow(radius: 10.0, x: 20, y: 10)

                            }
                            .sheet(isPresented: $showingSheet) {
                                AppointmentSheetView(showResponseMessage: $showResponseMessage,
                                                     messageTitle: $messageTitle,
                                                     messageContent: $messageContent,
                                                     messageColor: $messageColor,
                                                     appointments: $appointments
                                
                                )
                            }
                            .alert(isPresented: $showConfirmCancel) {
                                Alert(title: Text("Cancel the appointment"),
                                    message: Text("Are you sure ?"),
                                    primaryButton: .destructive(Text("Yes")) {
                                       self.delete(at:  self.index!) //call delete method
                                    },
                                    secondaryButton: .cancel())
                            }
                            .padding(.bottom, 20)
                            .padding(.leading, 200)
                        }
                    }
                }
            }.backgroundDesign()
        }
    }
    
    func delete(at offsets: IndexSet) {
        var appointmentsReverse: [Appointment] = appointments.reversed()
        appointmentsReverse.remove(atOffsets: offsets)
        appointments = appointmentsReverse.reversed()
    }
}

struct AppointmentRow: View {
    var appointment: Appointment

    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: self.appointment.status == "done" ?
                    "checkmark.seal.fill" : "clock")
                .frame(width: 20, height: 20)
                .foregroundColor(self.appointment.status == "done" ? Color.green : Color.blue)

            Text(appointment.date)
            Spacer()
            Text(appointment.speciality)
            Spacer()
            Text(appointment.doctor)
                .bold()

        }
    }
}

struct Appointment: Identifiable {
    let id = UUID()
    let date: String
    let status: String
    let doctor: String
    let speciality: String
}

let getAppointments = {
    return [
        Appointment(date: "08/06/2017",
                    status: "done", doctor: "Dr. Who", speciality: "General"),
        Appointment(date: "12/12/2018",
                    status: "done", doctor: "Dr. Who", speciality: "General"),
        Appointment(date: "21/02/2019",
                    status: "done", doctor: "Dr. Who", speciality: "General"),
        Appointment(date: "10/11/2020",
                        status: "done", doctor: "Dr. Amy", speciality: "Cardiology"),
        Appointment(date: "12/12/2020",
                        status: "done", doctor: "Dr. Who", speciality: "General"),
        Appointment(date: "23/12/2020",
                    status: "done", doctor: "Dr. Who", speciality: "General"),
        Appointment(date: "09/09/2021",
                        status: "pending", doctor: "Dr. Rory", speciality: "Pediatry"),
        Appointment(date: "17/10/2021",
                    status: "pending", doctor: "Dr. Rose", speciality: "Podology"),
        Appointment(date: "13/09/2021",
                    status: "other", doctor: "Dr. Who", speciality: "General"),
        Appointment(date: "12/12/2021",
                    status: "pending", doctor: "Dr. Rose", speciality: "Podology"),
        
    ]
}

//struct AppointmentLoggedView_Previews: PreviewProvider {
//    static var previews: some View {
//        AppointmentLoggedView()
//    }
//}
