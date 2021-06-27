//
//  registerView.swift
//  Whats-up-doc
//
//  Created by Hermance Dornier on 27/06/2021.
//

import SwiftUI

struct registerView: View {
    
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var gender: String = ""
    @State private var birthday: String = ""
    @State private var smoker: String = ""
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var password: String = ""
    @State private var passwordConfirm: String = ""
    @State private var showPassword: Bool = false
    @State private var selectedGenderIndex: Int = 0
    private var genderOptions = ["Male", "Female", "Other"]
    
    @State private var chooseGender = false
    
    var body: some View {

        VStack() {
            Text("Register")
                .font(.largeTitle).foregroundColor(Color.white)
                .padding([.top, .bottom], 40)
                .shadow(radius: 10.0, x: 20, y: 10)
        
            VStack(){
                TextField("Firstname", text: $firstname)
                    .padding()
                    .background(Color("textFieldColor"))
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                TextField("Lastname", text: $lastname)
                    .padding()
                    .background(Color("textFieldColor"))
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                TextField("Email", text: $email)
                    .padding()
                    .background(Color("textFieldColor"))
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                ZStack(alignment: .trailing) {
                    if showPassword {
                        TextField("Password", text: $password)
                            .padding()
                            .background(Color("textFieldColor"))
                            .cornerRadius(20.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                    } else {
                    SecureField("Password", text: $password)
                            .padding()
                            .background(Color("textFieldColor"))
                            .cornerRadius(20.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                    }
                    Button(action: {
                        showPassword.toggle()
                    }) {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .accentColor(.black).scaleEffect(0.8).padding()
                    }
                }
                ZStack(alignment: .trailing) {
                    if showPassword {
                        TextField("Password Confirm", text: $password)
                            .padding()
                            .background(Color("textFieldColor"))
                            .cornerRadius(20.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                    } else {
                    SecureField("Password Confirm", text: $password)
                            .padding()
                            .background(Color("textFieldColor"))
                            .cornerRadius(20.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                    }
                    Button(action: {
                        showPassword.toggle()
                    }) {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .accentColor(.black).scaleEffect(0.8).padding()
                    }
                }
                TextField("Phone", text: $phone)
                    .padding()
                    .background(Color("textFieldColor"))
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                Picker("Gender", selection: $selectedGenderIndex) {
                    ForEach(0..<genderOptions.count) {
                        Text(self.genderOptions[$0])
                    }
                }.pickerStyle(SegmentedPickerStyle())
                .background(Color("textFieldColor"))
                .cornerRadius(20.0)
                .shadow(radius: 10.0, x: 20, y: 10)
                TextField("Birthday", text: $email)
                    .padding()
                    .background(Color("textFieldColor"))
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                TextField("Smoker", text: $smoker)
                    .padding()
                    .background(Color("textFieldColor"))
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                TextField("Smoker", text: $email)
                    .padding()
                    .background(Color("textFieldColor"))
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
            }.padding([.leading, .trailing], 27.5)
            
            Button(action: {}) {
                Text("Sign up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 330, height: 50)
                    .background(Color.blue)
                    .cornerRadius(15.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
            }.padding(.top, 50)
            
            Spacer()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.green, .white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
        
    }
}

enum Gender: String, CaseIterable, Identifiable {
    case female
    case male
    case other

    var id: String { self.rawValue }
}

struct registerView_Previews: PreviewProvider {
    static var previews: some View {
        registerView()
    }
}
