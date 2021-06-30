//
//  RegisterView.swift
//  Whats-up-doc
//
//  Created by Aymeric Larvet on 27/06/2021.
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
    @State private var showPasswordConfirm: Bool = false
    @State private var showsDatePicker: Bool = false
    @State private var selectedGenderIndex: Int = 0
    @State private var isEnabled = false
    @State private var firstTapePasswordField = true
    @State private var firstTapePasswordConfirmField = true
    
    @ObservedObject private var height = DecimalOnly()
    @ObservedObject private var weight = DecimalOnly()
    @ObservedObject private var phone = NumbersOnly()
    
    let validator = Validator()
    @State var emailErrorMsg: String? = ""
    @State var firstnameErrorMsg: String? = ""
    @State var lastnameErrorMsg: String? = ""
    @State var phoneErrorMsg: String? = ""
    @State var passwordErrorMsg: String? = ""
    @State var passwordConfirmErrorMsg: String? = ""
    @State var weightErroMsg: String? = ""
    @State var heightErrorMsg: String? = ""
    
    private var genderOptions = ["Male", "Female", "Other"]
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }()
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView() {
                VStack(){
                    Section(header: Text("Account").foregroundColor(.white)) {
                        
                        ZStack(alignment: .center) {
                            TextField("Email", text: $email, onEditingChanged: { editingChanged in
                                if editingChanged {
                                    emailErrorMsg = ""
                                    checkPasswordFields()
                                } else {
                                    emailErrorMsg = validator.validateField(text: [email], with: [.notEmpty, .validEmail])
                                }})
                                .padding()
                                .background(Color("lightGray"))
                                .cornerRadius(20.0)
                                .shadow(radius: 10.0, x: 20, y: 10)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                            
                            if emailErrorMsg != "" && emailErrorMsg != nil {
                                ErrorMessageView(errorMsg: "\(emailErrorMsg!)")
                            }
                        }
                        
                        ZStack(alignment: .center) {
                            ZStack(alignment: .trailing) {
                                if showPassword {
                                    TextField("Password", text: $password, onEditingChanged: { editingChanged in
                                        if editingChanged {
                                            passwordErrorMsg = ""
                                        } else {
                                            passwordErrorMsg = validator.validateField(text: [password], with: [.notEmpty, .passwordlength])
                                        }
                                    })
                                    .padding()
                                    .background(Color("lightGray"))
                                    .cornerRadius(20.0)
                                    .shadow(radius: 10.0, x: 20, y: 10)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                } else {
                                    SecureField("Password", text: $password)
                                        .onTapGesture {
                                            passwordErrorMsg = ""
                                            firstTapePasswordField = false
                                        }
                                        .padding()
                                        .background(Color("lightGray"))
                                        .cornerRadius(20.0)
                                        .shadow(radius: 10.0, x: 20, y: 10)
                                        .disableAutocorrection(true)
                                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                }
                                Button(action: {
                                    showPassword.toggle()
                                }) {
                                    Image(systemName: showPassword ? "eye.slash" : "eye")
                                        .accentColor(Color("primary")).scaleEffect(0.8).padding()
                                }
                            }
                            
                            if passwordErrorMsg != "" && passwordErrorMsg != nil {
                                ErrorMessageView(errorMsg: "\(passwordErrorMsg!)")
                            }
                        }

                        ZStack(alignment: .center) {
                            ZStack(alignment: .trailing) {
                                if showPasswordConfirm {
                                    TextField("Password Confirm", text: $passwordConfirm, onEditingChanged: { editingChanged in
                                        if editingChanged {
                                            passwordConfirmErrorMsg = ""
                                        } else {
                                            passwordConfirmErrorMsg = validator.validateField(text: [passwordConfirm, password], with: [.notEmpty, .validPasswordConfirm])
                                        }
                                    })
                                    .padding()
                                    .background(Color("lightGray"))
                                    .cornerRadius(20.0)
                                    .shadow(radius: 10.0, x: 20, y: 10)
                                    .disableAutocorrection(true)
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                } else {
                                    SecureField("Password Confirm", text: $passwordConfirm)
                                        .onTapGesture {
                                            passwordConfirmErrorMsg = ""
                                            firstTapePasswordConfirmField = false
                                        }
                                        .padding()
                                        .background(Color("lightGray"))
                                        .cornerRadius(20.0)
                                        .shadow(radius: 10.0, x: 20, y: 10)
                                        .disableAutocorrection(true)
                                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                }
                                Button(action: {
                                    showPasswordConfirm.toggle()
                                }) {
                                    Image(systemName: showPasswordConfirm ? "eye.slash" : "eye")
                                        .accentColor(Color("primary")).scaleEffect(0.8).padding()
                                }
                            }
                            
                            if passwordConfirmErrorMsg != "" && passwordConfirmErrorMsg != nil {
                                ErrorMessageView(errorMsg: "\(passwordConfirmErrorMsg!)")
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
                            TextField("Firstname", text: $firstname, onEditingChanged: { editingChanged in
                                if editingChanged {
                                    firstnameErrorMsg = ""
                                    checkPasswordFields()
                                } else {
                                    firstnameErrorMsg = validator.validateField(text: [firstname], with: [.notEmpty, .fieldlenght])
                                }
                            })
                                .padding()
                                .background(Color("lightGray"))
                                .cornerRadius(20.0)
                                .shadow(radius: 10.0, x: 20, y: 10)
                                .disableAutocorrection(true)
                            
                            if firstnameErrorMsg != "" && firstnameErrorMsg != nil {
                                ErrorMessageView(errorMsg: "\(firstnameErrorMsg!)")
                            }
                        }

                        ZStack(alignment: .center) {
                            TextField("Lastname", text: $lastname, onEditingChanged: { editingChanged in
                                if editingChanged {
                                    lastnameErrorMsg = ""
                                    checkPasswordFields()
                                } else {
                                    lastnameErrorMsg = validator.validateField(text: [lastname], with: [.notEmpty, .fieldlenght])
                                }
                            })
                                .padding()
                                .background(Color("lightGray"))
                                .cornerRadius(20.0)
                                .shadow(radius: 10.0, x: 20, y: 10)
                                .disableAutocorrection(true)
                            
                            if lastnameErrorMsg != "" && lastnameErrorMsg != nil {
                                ErrorMessageView(errorMsg: "\(lastnameErrorMsg!)")
                            }
                        }
                        
                        ZStack(alignment: .trailing) {
                            HStack {
                                Text("Date of Birthday")

                               Spacer()
                                Text("\(dateFormatter.string(from: birthday))")
                                    .onTapGesture {
                                        self.showsDatePicker.toggle()
                                    }
                                    .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
                                    .foregroundColor(.blue)
                            }.padding()
                            .background(Color("lightGray"))
                            .cornerRadius(20.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                        }
                        
                        ZStack(alignment: .center) {
                            TextField("Phone", text: $phone.value, onEditingChanged: { editingChanged in
                                if editingChanged {
                                    phoneErrorMsg = ""
                                    checkPasswordFields()
                                } else {
                                    phoneErrorMsg = validator.validateField(text: [phone.value], with: [.notEmpty, .validPhone])
                                }
                            })
                                .padding()
                                .background(Color("lightGray"))
                                .cornerRadius(20.0)
                                .shadow(radius: 10.0, x: 20, y: 10)
                                .keyboardType(.numberPad)
                                .disableAutocorrection(true)
                            
                            if phoneErrorMsg != "" && phoneErrorMsg != nil {
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
                                    TextField("Weight", text: $weight.value, onEditingChanged: { editingChanged in
                                        if editingChanged {
                                            weightErroMsg = ""
                                            checkPasswordFields()
                                        } else {
                                            weightErroMsg = validator.validateField(text: [weight.value], with: [.notEmpty, .isDecimal])
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
                            
                            if weightErroMsg != "" && weightErroMsg != nil {
                                ErrorMessageView(errorMsg: "\(weightErroMsg!)")
                            }
                        }
                        
                        ZStack(alignment: .center) {
                            ZStack(alignment: .trailing) {
                                    TextField("Height", text: $height.value, onEditingChanged: { editingChanged in
                                        if editingChanged {
                                            heightErrorMsg = ""
                                            checkPasswordFields()
                                        } else {
                                            heightErrorMsg = validator.validateField(text: [height.value], with: [.notEmpty, .isDecimal])
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
                            
                            if heightErrorMsg != ""  && heightErrorMsg != nil {
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
            }.overlay((self.showsDatePicker ? Color.black.opacity(0.3) : Color.clear)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                self.showsDatePicker.toggle()
            })

            if self.showsDatePicker {
                HStack(){
                        DatePicker("", selection: $birthday, displayedComponents: .date)
                            .datePickerStyle(WheelDatePickerStyle())
                    }
                    .offset(y: self.showsDatePicker ? 0 : UIScreen.main.bounds.height)
                    .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
                    .padding(.horizontal)
                    .padding(.top,20)
                    .background(Color("lightGray"))
                    .edgesIgnoringSafeArea(.bottom)
            }
            
        }
        .animation(.default, value: showsDatePicker)
        .background(
            LinearGradient(gradient: Gradient(colors: [.green, Color("lightGray")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
        .navigationBarTitle("Register", displayMode: .inline)
    }
    
    func checkPasswordFields() -> Void {
        if !firstTapePasswordField {
            passwordErrorMsg = validator.validateField(text: [password], with: [.notEmpty, .passwordlength])
        }
        
        if !firstTapePasswordConfirmField {
            passwordConfirmErrorMsg = validator.validateField(text: [passwordConfirm, password], with: [.notEmpty, .validPasswordConfirm])
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
