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
    
    let validator = Validator()
    @State var emailErrorMsg: String? = ""
    @State var firstnameErrorMsg: String? = ""
    @State var lastnameErrorMsg: String? = ""
    @State var phoneErrorMsg: String? = ""
    @State var passwordErrorMsg: String? = ""
    @State var weightErroMsg: String? = ""
    @State var heightErrorMsg: String? = ""

    private var genderOptions = ["Male", "Female", "Other"]
    
    var body: some View {
        VStack() {
            ScrollView() {
                VStack(){
                    Section(header: Text("Account").foregroundColor(.white)) {
                        ZStack(alignment: .center) {
                            TextField("Email", text: $email, onEditingChanged: { (editingChanged) in
                                    if editingChanged {
                                        emailErrorMsg = ""
                                    } else {
                                        emailErrorMsg = validator.validateField(text: email, with: [.notEmpty, .validEmail])
                                    }
                                })
                                .padding()
                                .background(Color("lightGray"))
                                .cornerRadius(20.0)
                                .shadow(radius: 10.0, x: 20, y: 10)
                                .disableAutocorrection(true)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            
                            if emailErrorMsg != "" {
                                ErrorMessageView(errorMsg: "\(emailErrorMsg!)")
                            }
                        }
                        
                        ZStack(alignment: .center) {
                            ZStack(alignment: .trailing) {
                                if showPassword {
                                    TextField("Password", text: $password, onEditingChanged: { (editingChanged) in
                                        if editingChanged {
                                            passwordErrorMsg = ""
                                        } else {
                                            passwordErrorMsg = validator.validateField(text: password, with: [.notEmpty, .passwordlength])
                                        }
                                    })
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
                                        .accentColor(Color("primary")).scaleEffect(0.8).padding()
                                }
                            }
                            
                            if passwordErrorMsg != "" {
                                ErrorMessageView(errorMsg: "\(passwordErrorMsg!)")
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
                                    .accentColor(Color("primary")).scaleEffect(0.8).padding()
                            }
                        }
                    }.padding([.top,.bottom],5)
                    
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

                        ZStack(alignment: .center) {
                            TextField("Firstname", text: $firstname, onEditingChanged: { (editingChanged) in
                                if editingChanged {
                                    firstnameErrorMsg = ""
                                } else {
                                    firstnameErrorMsg = validator.validateField(text: firstname, with: [.notEmpty, .fieldlenght])
                                }
                            })
                                .padding()
                                .background(Color("lightGray"))
                                .cornerRadius(20.0)
                                .shadow(radius: 10.0, x: 20, y: 10)
                                .disableAutocorrection(true)
                            
                            if firstnameErrorMsg != "" {
                                ErrorMessageView(errorMsg: "\(firstnameErrorMsg!)")
                            }
                        }

                        ZStack(alignment: .center) {
                            TextField("Lastname", text: $lastname, onEditingChanged: { (editingChanged) in
                                if editingChanged {
                                    lastnameErrorMsg = ""
                                } else {
                                    lastnameErrorMsg = validator.validateField(text: lastname, with: [.notEmpty, .fieldlenght])
                                }
                            })
                                .padding()
                                .background(Color("lightGray"))
                                .cornerRadius(20.0)
                                .shadow(radius: 10.0, x: 20, y: 10)
                                .disableAutocorrection(true)
                            
                            if lastnameErrorMsg != "" {
                                ErrorMessageView(errorMsg: "\(lastnameErrorMsg!)")
                            }
                        }
                        
                        DatePicker(selection: $birthday, in: ...Date(), displayedComponents: .date) {
                            Text("Birthday")
                                .padding()
                        }.padding(.trailing)
                        .background(Color("lightGray"))
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                        
                        ZStack(alignment: .center) {
                            TextField("Phone", text: $phone.value, onEditingChanged: { (editingChanged) in
                                if editingChanged {
                                    phoneErrorMsg = ""
                                } else {
                                    phoneErrorMsg = validator.validateField(text: phone.value, with: [.notEmpty, .validPhone])
                                }
                            })
                                .padding()
                                .background(Color("lightGray"))
                                .cornerRadius(20.0)
                                .shadow(radius: 10.0, x: 20, y: 10)
                                .disableAutocorrection(true)
                            
                            if phoneErrorMsg != "" {
                                ErrorMessageView(errorMsg: "\(phoneErrorMsg!)")
                            }
                        }
                    }.padding(.bottom, 10)
                    
                    Section(header: Text("Healt").foregroundColor(.white)) {
                        
                        Toggle(isOn: $smoker, label: {
                            Text("Smoker")
                        })
                        .padding()
                        .background(Color("lightGray"))
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                        .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                        

                        
                        ZStack(alignment: .center) {
                            ZStack(alignment: .trailing) {
                                    TextField("Weight", text: $weight.value, onEditingChanged: { (editingChanged) in
                                        if editingChanged {
                                            weightErroMsg = ""
                                        } else {
                                            weightErroMsg = validator.validateField(text: weight.value, with: [.notEmpty, .isDecimal])
                                        }
                                    })
                                    .padding()
                                    .background(Color("lightGray"))
                                    .cornerRadius(20.0)
                                    .shadow(radius: 10.0, x: 20, y: 10)
                                    .keyboardType(.numberPad)
                                    .disableAutocorrection(true)
                            
                                Text("kg")
                                    .padding(.trailing, 35)
                            }
                            
                            if weightErroMsg != "" {
                                ErrorMessageView(errorMsg: "\(weightErroMsg!)")
                            }
                        }
                        
                        ZStack(alignment: .center) {
                            ZStack(alignment: .trailing) {
                                    TextField("Height", text: $height.value, onEditingChanged: { (editingChanged) in
                                        if editingChanged {
                                            heightErrorMsg = ""
                                        } else {
                                            heightErrorMsg = validator.validateField(text: height.value, with: [.notEmpty, .isDecimal])
                                        }
                                    })
                                    .padding()
                                    .background(Color("lightGray"))
                                    .cornerRadius(20.0)
                                    .shadow(radius: 10.0, x: 20, y: 10)
                                    .keyboardType(.numberPad)
                                    .disableAutocorrection(true)
                            
                                Text("cm")
                                    .padding(.trailing, 35)
                            }
                            
                            if heightErrorMsg != "" {
                                ErrorMessageView(errorMsg: "\(heightErrorMsg!)")
                            }
                        }
                        
                    }.padding(.bottom, 10)
                    
                    Button(action: {
                    }) {
                        Text("Submit")
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

class Validator {
    func validateField(text: String, with rules: [Rule]) -> String? {
        return rules.compactMap({ $0.check(text) }).first
    }
}

struct Rule {
    // Return nil if matches, error message otherwise
    let check: (String) -> String

    static let notEmpty = Rule(check: {
        return $0.isEmpty ? "Must not be empty" : ""
    })

    static let validEmail = Rule(check: {
        let regex = #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}"#

        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: $0) ? "" : "Must have valid email"
    })
    
    static let validPhone = Rule(check: {
        let regex = #"(?:(?:\+|00)33|0)\s*[1-9](?:[\s.-]*\d{2}){4}"#


        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: $0) ? "" : "Must have valid phone number"
    })
    
    static let fieldlenght = Rule(check: {
        return $0.count > 1 && $0.count < 20 ? "" : "Must contain between 2 and 20 characters"
    })
    
    static let passwordlength = Rule(check: {
        return $0.count > 4 && $0.count < 20 ? "" : "Must contain between 5 and 20 characters"
    })
    
    static let isDecimal = Rule(check: {
        let regex = #"^[0-9]{1,3}.?[0-9]{0,2}"#

        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: $0) ? "" : "Must have prefix country code"
    })

    static let countryCode = Rule(check: {
        let regex = #"^\+\d+.*"#

        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: $0) ? "" : "Must have prefix country code"
    })
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
