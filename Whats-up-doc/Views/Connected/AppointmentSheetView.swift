//
//  AppointmentSheetView.swift
//  Whats-up-doc
//
//  Created by Hermance Dornier on 25/07/2021.
//

import SwiftUI

struct Item: Identifiable {
    let id: String
    let name: String
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

struct AppointmentSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showSpecialitiesPicker: Bool = false
    @State private var showDoctorPicker: Bool = false
    @State private var showDatePicker: Bool = false
    
    @State private var selectedDateIndex = 0
    @State private var selectedDoctorIndex = 0
    @State private var selectedSpecialityIndex = 0


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
                            self.showSpecialitiesPicker.toggle()
                        }
                    Image(systemName: showSpecialitiesPicker ? "chevron.up" : "chevron.down")
                        .resizable()
                        .frame(width:13, height: 6)
                        .foregroundColor(.black)
                        .onTapGesture {
                            self.showSpecialitiesPicker.toggle()
                        }
                }
                Spacer()
                HStack(){
                    Text("\(getDoctors()[selectedDoctorIndex].name)")
                        .onTapGesture {
                            self.showDoctorPicker.toggle()
                        }
                    Image(systemName: showDoctorPicker ? "chevron.up" : "chevron.down")
                        .resizable()
                        .frame(width:13, height: 6)
                        .foregroundColor(.black)
                        .onTapGesture {
                            self.showDoctorPicker.toggle()
                        }
                }
                Spacer()
                HStack(){
                    Text("\(getDateAndTime()[selectedDateIndex].name)")
                        .onTapGesture {
                            self.showDatePicker.toggle()
                        }
                    Image(systemName: showDatePicker ? "chevron.up" : "chevron.down")
                        .resizable()
                        .frame(width:13, height: 6)
                        .foregroundColor(.black)
                        .onTapGesture {
                            self.showDatePicker.toggle()
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
