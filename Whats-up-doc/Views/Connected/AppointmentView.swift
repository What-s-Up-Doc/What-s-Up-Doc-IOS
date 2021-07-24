//
//  AppointmentView.swift
//  Whats-up-doc
//
//  Created by Aymeric Larvet on 27/06/2021.
//

import SwiftUI

struct AppointmentView: View {
    @StateObject private var userData: UserData = UserData()
    
    var body: some View {
        if userData.isLoggedIn {
            AppointmentLoggedView()
        } else {
            NavigationView {
                AppointmentNotLogged()
            }
        }
    }
}

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
                    SheetView()
                }.padding(.top, 50)
                .padding(.bottom, 20)
                .padding(.horizontal, 10)
            }
        }.background(Color.green)
    }
}

struct Appointment: Identifiable {
    let id = UUID()
    let date: String
    let status: String
    let doctor: String
    let patient: String
}

struct Item: Codable, Hashable, Identifiable {
    let id: String
    var name: String
}

struct Test: Hashable {
    var index: Int = 0
}

struct SheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showSelector: Bool = false
    @State private var selectedSpecialityIndex = 0
    @State var indexTest: Test = Test(index: 0)


    var body: some View {
        ZStack(alignment: .bottom){
            Spacer()
            Text("New Appointment")
                .font(.largeTitle)
                .shadow(radius: 10.0, x: 20, y: 10)
                .foregroundColor(.white)
                .padding()
            Spacer()
            VStack(){
                Spacer()
                HStack(){
                    Text("\(getSpecialities()[selectedSpecialityIndex].name)")
                        .onTapGesture {
                            self.showSelector.toggle()
                        }
                }
                Spacer()
                HStack(){
                    DropDown(items: getDoctors(), selection: "Doctor")
                }
                Spacer()
                HStack(){
                    DropDown(items: getDateAndTime(), selection: "Date and Time")
                }
                Spacer()
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Validate")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 10.0, x: 20, y: 10)

                }.padding(.top, 50)
                .padding(.horizontal, 10)
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                        .shadow(radius: 10.0, x: 20, y: 10)

                }.padding(.vertical, 10)
                .padding(.horizontal, 10)
                
            }.overlay((self.showSelector ? Color.black.opacity(0.3) : Color.clear)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                self.showSelector.toggle()
            })

            if showSelector {
                HStack(){
                    Picker("Speciality", selection: $selectedSpecialityIndex, content: {
                        ForEach(0..<getSpecialities().count, content: { index in
                            Text(getSpecialities()[index].name)
                        })
                    })
                }
                .zIndex(10)
                .offset(y: self.showSelector ? 0 : UIScreen.main.bounds.height)
                .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
                .padding(.horizontal)
                .padding(.top,20)
                .background(Color("lightGray"))
                .edgesIgnoringSafeArea(.bottom)


            }

        } .background(
            LinearGradient(gradient: Gradient(colors: [.green, Color("lightGray")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
    }
}

class SpecialitiesController: ObservableObject {
    @Published var specialities: [Item] = []

    init() {
        specialities = [
            Item(id: "0", name: "Generalist"),
            Item(id: "1", name: "Cardiology"),
            Item(id: "2", name: "Gynecology"),
            Item(id: "3", name: "Pediatry"),
            Item(id: "4", name: "Podology"),
            Item(id: "5", name: "Sophrology")
        ]
    }
}

struct DropDown: View {
    @State var expand = false
    var items: [Item]
    @State var selection: String
    var body: some View{
        VStack(){
            VStack(spacing: 30){
                HStack(){
                    Text(selection)
                    Image(systemName: expand ? "chevron.up" : "chevron.down")
                        .resizable()
                        .frame(width:13, height: 6)
                        .foregroundColor(.black)
                }.onTapGesture {
                    self.expand.toggle()
                }
                if expand {
                    List {
                        ForEach(items) { item in
                            Button(action: {
                                selection = item.name
                                self.expand.toggle()
                            }){
                                Text(item.name).padding()
                            }.foregroundColor(.black)
                        }
                    }
                }
            }
            .shadow(color: .gray, radius: 5)
            .animation(.spring())
        }
    }
}

let getDateAndTime = {
    return [
        Item(id: "1", name: "Monday, 12th May 2021"),
        Item(id: "2", name: "Thursday, 22 June 2021"),
    ]
}

let getSpecialities = {
    return [
        Item(id: "1", name: "Generalist"),
        Item(id: "2", name: "Cardiology"),
        Item(id: "3", name: "Gynecology"),
        Item(id: "4", name: "Pediatry"),
        Item(id: "5", name: "Podology"),
        Item(id: "6", name: "Sophrology")
    ]
}

let getDoctors = {
    return [
        Item(id: "1", name: "Doctor Who"),
        Item(id: "3", name: "Doctor Rand"),
        Item(id: "4", name: "Doctor Aybara"),
        Item(id: "5", name: "Doctor Moiraine"),
        Item(id: "6", name: "Doctor Mordeth")
    ]
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

struct AppointmentNotLogged: View {
    var body: some View {
        ZStack(alignment: .top){
            VStack() {
                HeaderComponent()
                Spacer()
                Text("You must be connected to take an appointment.")
                HStack {
                    Text("Please ")
                    NavigationLink(destination: LoginView()){
                        Text("login")
                    }
                }
                HStack(spacing: 0) {
                    Text("Don't have an account? ")
                    NavigationLink(destination: RegisterView()){
                        Text("Sign Up")
                    }//.navigationBarTitle("Login", displayMode: .inline)
                }
                Spacer()

            }.frame(
                minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,
                maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,
                maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/
            )
            .background(
                LinearGradient(gradient: Gradient(colors: [.green, Color("lightGray")]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all))
        }
    }
}
