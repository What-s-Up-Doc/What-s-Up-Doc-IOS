//
//  AppointmentSheetView.swift
//  Whats-up-doc
//
//  Created by Aymeric Larvet on 25/07/2021.
//

import SwiftUI

struct Item: Identifiable {
    let id: String
    let name: String
}

let getDateAndTime = {
    return [
        Item(id: "0", name: "Pick a Date"),
        Item(id: "1", name: "06/09/2021 11h00"),
        Item(id: "2", name: "06/09/2021 11h00"),
        Item(id: "3", name: "06/09/2021 15h40"),
        Item(id: "4", name: "07/09/2021 9h40"),
        Item(id: "5", name: "07/09/2021 11h00"),
        Item(id: "6", name: "07/09/2021 19h00"),
        Item(id: "7", name: "08/09/2021 8h00"),
    ]
}

let getSpecialities = {
    return [
        Item(id: "0", name: "Pick a Speciality"),
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
        Item(id: "0", name: "Pick a Doctor"),
        Item(id: "1", name: "Doctor Who"),
        Item(id: "3", name: "Doctor Rand"),
        Item(id: "4", name: "Doctor Aybara"),
        Item(id: "5", name: "Doctor Moiraine"),
        Item(id: "6", name: "Doctor Mordeth")
    ]
}

struct AppointmentSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showSpecialitiesPicker: Bool = false
    @State private var showDoctorPicker: Bool = false
    @State private var showDatePicker: Bool = false
    @State private var selectedSpeciality: Bool = false
    @State private var selectedDoctor: Bool = false
    
    @State private var selectedDateIndex = 0
    @State private var selectedDoctorIndex = 0
    @State private var selectedSpecialityIndex = 0
    
    


    var body: some View {
        ZStack(alignment: .bottom){
            VStack(){
                
                VStack() {
                    HStack(){
                        Text("New Appointment")
                            .font(.largeTitle)
                            .shadow(radius: 10.0, x: 20, y: 10)
                            .foregroundColor(.white)
                            .padding()
                    }
                    

                    HStack(){
                        Image(systemName: "calendar.badge.plus")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 20))
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10.0, x: 20, y: 10)
                            .padding(.bottom, 20)
                    }
                    
                }
                
                Spacer()
                PickerValueComponent(icon: "stethoscope", title:"Speciality", pickerValue: getSpecialities()[selectedSpecialityIndex].name, showPicker: $showSpecialitiesPicker)
                .onTapGesture {
                    self.showSpecialitiesPicker.toggle()
                }
                
                Spacer()
                ZStack(alignment: .center) {
                    PickerValueComponent(icon: "person", title:"Doctor", pickerValue: getDoctors()[selectedDoctorIndex].name, showPicker: $showDoctorPicker)
                    .onTapGesture {
                        self.showDoctorPicker.toggle()
                    }.allowsHitTesting(selectedSpecialityIndex != 0)
                    
                    if selectedSpecialityIndex == 0 {
                        WarningMessageComponent(warningMsg: "Choose a Speciality")
                    }
                    
                }


                Spacer()
                ZStack(alignment: .center) {
                    PickerValueComponent(icon: "clock", title:"Schedule", pickerValue: getDateAndTime()[selectedDateIndex].name, showPicker: $showDatePicker)
                    .onTapGesture {
                        self.showDatePicker.toggle()
                    }.allowsHitTesting(selectedDoctorIndex != 0)
                    
                    if selectedDoctorIndex == 0 {
                        WarningMessageComponent(warningMsg: "Choose a Speciality and a Doctor")
                    }
                    
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
                
            }.overlay((self.showSpecialitiesPicker || self.showDoctorPicker || self.showDatePicker ? Color.black.opacity(0.3) : Color.clear)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                self.showSpecialitiesPicker = false
                self.showDoctorPicker = false
                self.showDatePicker = false
            })

            if showSpecialitiesPicker {
                PickerComponent(pickerIndex: $selectedSpecialityIndex, pickerList: getSpecialities())
                    .offset(y: self.showSpecialitiesPicker ? 0 : UIScreen.main.bounds.height)
                    .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
                    .padding(.horizontal)
                    .padding(.top,20)
                    .background(Color("lightGray"))
                    .edgesIgnoringSafeArea(.bottom)
            }
            
            if showDoctorPicker {
                PickerComponent(pickerIndex: $selectedDoctorIndex, pickerList: getDoctors())
                    .offset(y: self.showDoctorPicker ? 0 : UIScreen.main.bounds.height)
                    .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
                    .padding(.horizontal)
                    .padding(.top,20)
                    .background(Color("lightGray"))
                    .edgesIgnoringSafeArea(.bottom)
            }

            if showDatePicker {
                PickerComponent(pickerIndex: $selectedDateIndex, pickerList: getDateAndTime())
                    .offset(y: self.showDatePicker ? 0 : UIScreen.main.bounds.height)
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

struct AppointmentSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentSheetView()
    }
}
