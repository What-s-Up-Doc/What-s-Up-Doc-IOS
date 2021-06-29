//
//  registerView.swift
//  Whats-up-doc
//
//  Created by Hermance Dornier on 27/06/2021.
//

import SwiftUI

struct RegisterView: View {
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var email: String = ""
    @State private var gender: String = ""
    @State private var birthday = Date()
    @State private var smoker: Bool = false
    @State private var password: String = ""
    @State private var passwordConfirm: String = ""
    @State private var showPassword: Bool = false
    @State private var selectedGenderIndex: Int = 0
    
    @ObservedObject private var height = DecimalOnly()
    @ObservedObject private var weight = DecimalOnly()
    @ObservedObject private var phone = NumbersOnly()

    private var genderOptions = ["Male", "Female", "Other"]
    
    var body: some View {
        VStack() {
            ScrollView() {
                VStack(){
                    Section(header: Text("Account").foregroundColor(.white)) {
                        TextField("Email", text: $email)
                            .padding()
                            .background(Color("lightGray"))
                            .cornerRadius(20.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                            .disableAutocorrection(true)
                        
                        
                        ZStack(alignment: .trailing) {
                            if showPassword {
                                TextField("Password", text: $password)
                                    .padding()
                                    .background(Color("lightGray"))
                                    .cornerRadius(20.0)
                                    .shadow(radius: 10.0, x: 20, y: 10)
                                    .disableAutocorrection(true)
                            } else {
                                SecureField("Password", text: $password)
                                        .padding()
                                        .background(Color("lightGray"))
                                        .cornerRadius(20.0)
                                        .shadow(radius: 10.0, x: 20, y: 10)
                                        .disableAutocorrection(true)
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
                                TextField("Password Confirm", text: $passwordConfirm)
                                    .padding()
                                    .background(Color("lightGray"))
                                    .cornerRadius(20.0)
                                    .shadow(radius: 10.0, x: 20, y: 10)
                                    .disableAutocorrection(true)
                            } else {
                                SecureField("Password Confirm", text: $passwordConfirm)
                                        .padding()
                                        .background(Color("lightGray"))
                                        .cornerRadius(20.0)
                                        .shadow(radius: 10.0, x: 20, y: 10)
                                        .disableAutocorrection(true)
                            }
                            Button(action: {
                                showPassword.toggle()
                            }) {
                                Image(systemName: showPassword ? "eye.slash" : "eye")
                                    .accentColor(.black).scaleEffect(0.8).padding()
                            }
                        }
                    }.padding([.top,.bottom])
                    
                    Section(header: Text("Personal").foregroundColor(.white)) {
                        Picker("Gender", selection: $selectedGenderIndex) {
                            ForEach(0..<genderOptions.count) {
                                Text(self.genderOptions[$0])


                            }
                        }.padding(10)
                        .background(Color("lightGray"))
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                        .pickerStyle(SegmentedPickerStyle()).background(Color.clear)

                        
                        TextField("Firstname", text: $firstname)
                            .padding()
                            .background(Color("lightGray"))
                            .cornerRadius(20.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                            .disableAutocorrection(true)

                        TextField("Lastname", text: $lastname)
                            .padding()
                            .background(Color("lightGray"))
                            .cornerRadius(20.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                            .disableAutocorrection(true)
                        
                        DatePicker(selection: $birthday, in: ...Date(), displayedComponents: .date) {
                            Text("Birthday")
                                .padding([.leading, .top, .bottom], 20)
                        }
                        .background(Color("lightGray"))
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                        
                        TextField("Phone", text: $phone.value)
                            .padding()
                            .background(Color("lightGray"))
                            .cornerRadius(20.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                            .keyboardType(.numberPad)
                            .disableAutocorrection(true)
                    }.padding(.bottom, 10)
                    
                    Section(header: Text("Healt").foregroundColor(.white)) {
                        
                        Toggle(isOn: $smoker, label: {
                            Text("Smoker")
                        })
                        .padding()
                        .background(Color("lightGray"))
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                        .toggleStyle(CheckboxStyle())
                        
                        TextField("Weight", text: $weight.value)
                            .padding()
                            .background(Color("lightGray"))
                            .cornerRadius(20.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                            .keyboardType(.numberPad)
                            .disableAutocorrection(true)
                        
                        TextField("Height", text: $height.value)
                            .padding()
                            .background(Color("lightGray"))
                            .cornerRadius(20.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                            .keyboardType(.numberPad)
                            .disableAutocorrection(true)
                        
                        
                    }.padding(.bottom, 10)
                    
                    Button(action: {}) {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 330, height: 50)
                            .background(Color.blue)
                            .cornerRadius(15.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                    }.padding([.top,.bottom], 50)
                    
                }.padding([.leading, .trailing], 27.5)
            }
            Spacer()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.green, Color("lightGray")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
        .navigationBarTitle("Register", displayMode: .inline)
    }
}

struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        return HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .blue : .gray)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}

class DecimalOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter { "0123456789.".contains($0) }
            
            if value != filtered  {
                value = filtered
            }
        }
    }
}

class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter { $0.isNumber }
            
            if value != filtered  {
                value = filtered
            }
        }
    }
}

struct registerView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
