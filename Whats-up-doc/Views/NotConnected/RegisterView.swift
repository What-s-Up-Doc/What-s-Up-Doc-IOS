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
    @State private var firstTapePasswordField = true
    @State private var firstTapePasswordConfirmField = true
    @State private var firstTapeBirthdayField = true
    @State private var showResponseMessage = false
    @State private var messageTitle: String = ""
    @State private var messageContent: String = ""
    @State private var messageColor: Color = Color.blue
    
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
    @State var birthdayErrorMsg: String? = ""
    
    private var genderOptions = ["Male", "Female", "Other"]
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return dateFormatter
    }()
    
    let dateFormatter2: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter
    }()
    
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
            VStack(spacing: 0) {
                ScrollView() {
                    VStack(alignment: .leading){
                        Section(header: HeaderSectionView(title: "Account",icon: "person.crop.circle.fill")) {
                            ZStack(alignment: .center) {
                                TextField("Email", text: $email, onEditingChanged: { editingChanged in
                                    if editingChanged {
                                        emailErrorMsg = ""
                                        checkPasswordFields()
                                        checkBirthdayField()
                                    } else {
                                        emailErrorMsg = validator.validateField(text: [email], with: [.notEmpty, .validEmail]) == nil ? "" : validator.validateField(text: [email], with: [.notEmpty, .validEmail])
                                    }})
                                    .padding()
                                    .background(Color("lightGray"))
                                    .cornerRadius(20.0)
                                    .shadow(radius: 10.0, x: 20, y: 10)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                
                                if emailErrorMsg != "" && emailErrorMsg != nil {
                                    ErrorMessageComponent(errorMsg: "\(emailErrorMsg!)")
                                }
                            }
                            
                            ZStack(alignment: .center) {
                                ZStack(alignment: .trailing) {
                                    if showPassword {
                                        TextField("Password", text: $password, onEditingChanged: { editingChanged in
                                            if editingChanged {
                                                passwordErrorMsg = ""
                                            } else {
                                                passwordErrorMsg = validator.validateField(text: [password], with: [.notEmpty, .passwordlength]) == nil ? "" : validator.validateField(text: [password], with: [.notEmpty, .passwordlength])
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
                                    ErrorMessageComponent(errorMsg: "\(passwordErrorMsg!)")
                                }
                            }

                            ZStack(alignment: .center) {
                                ZStack(alignment: .trailing) {
                                    if showPasswordConfirm {
                                        TextField("Password Confirm", text: $passwordConfirm, onEditingChanged: { editingChanged in
                                            if editingChanged {
                                                passwordConfirmErrorMsg = ""
                                            } else {
                                                passwordConfirmErrorMsg = validator.validateField(text: [passwordConfirm, password], with: [.notEmpty, .validPasswordConfirm]) == nil ? "" : validator.validateField(text: [passwordConfirm, password], with: [.notEmpty, .validPasswordConfirm])
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
                                    ErrorMessageComponent(errorMsg: "\(passwordConfirmErrorMsg!)")
                                }
                            }
                        }.padding([.top,.bottom],5)
                        
                        Section(header: HeaderSectionView(title: "Personal",icon: "person.fill")) {
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
                                        checkBirthdayField()
                                    } else {
                                        firstnameErrorMsg = validator.validateField(text: [firstname], with: [.notEmpty, .fieldlenght]) == nil ? "" : validator.validateField(text: [firstname], with: [.notEmpty, .fieldlenght])
                                    }
                                })
                                    .padding()
                                    .background(Color("lightGray"))
                                    .cornerRadius(20.0)
                                    .shadow(radius: 10.0, x: 20, y: 10)
                                    .disableAutocorrection(true)
                                
                                if firstnameErrorMsg != "" && firstnameErrorMsg != nil {
                                    ErrorMessageComponent(errorMsg: "\(firstnameErrorMsg!)")
                                }
                            }

                            ZStack(alignment: .center) {
                                TextField("Lastname", text: $lastname, onEditingChanged: { editingChanged in
                                    if editingChanged {
                                        lastnameErrorMsg = ""
                                        checkPasswordFields()
                                        checkBirthdayField()
                                    } else {
                                        lastnameErrorMsg = validator.validateField(text: [lastname], with: [.notEmpty, .fieldlenght]) == nil ? "" : validator.validateField(text: [lastname], with: [.notEmpty, .fieldlenght])
                                    }
                                })
                                    .padding()
                                    .background(Color("lightGray"))
                                    .cornerRadius(20.0)
                                    .shadow(radius: 10.0, x: 20, y: 10)
                                    .disableAutocorrection(true)
                                
                                if lastnameErrorMsg != "" && lastnameErrorMsg != nil {
                                    ErrorMessageComponent(errorMsg: "\(lastnameErrorMsg!)")
                                }
                            }
                            ZStack(alignment: .center) {
                                ZStack(alignment: .trailing) {
                                    HStack {
                                        Text("Date of Birthday")

                                       Spacer()
                                        Text("\(dateFormatter.string(from: birthday))")
                                            .onTapGesture {
                                                self.showsDatePicker.toggle()
                                                birthdayErrorMsg = ""
                                                firstTapeBirthdayField = false
                                            }
                                            .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
                                            .foregroundColor(.blue)
                                    }.padding()
                                    .background(Color("lightGray"))
                                    .cornerRadius(20.0)
                                    .shadow(radius: 10.0, x: 20, y: 10)
                                }
                                if birthdayErrorMsg != "" && birthdayErrorMsg != nil {
                                    ErrorMessageComponent(errorMsg: "\(birthdayErrorMsg!)")
                                }
                            }
                            
                            ZStack(alignment: .center) {
                                TextField("Phone", text: $phone.value, onEditingChanged: { editingChanged in
                                    if editingChanged {
                                        phoneErrorMsg = ""
                                        checkPasswordFields()
                                        checkBirthdayField()
                                    } else {
                                        phoneErrorMsg = validator.validateField(text: [phone.value], with: [.notEmpty, .validPhone]) == nil ? "" : validator.validateField(text: [phone.value], with: [.notEmpty, .validPhone])
                                    }
                                })
                                    .padding()
                                    .background(Color("lightGray"))
                                    .cornerRadius(20.0)
                                    .shadow(radius: 10.0, x: 20, y: 10)
                                    .keyboardType(.numberPad)
                                    .disableAutocorrection(true)
                                
                                if phoneErrorMsg != "" && phoneErrorMsg != nil {
                                    ErrorMessageComponent(errorMsg: "\(phoneErrorMsg!)")
                                }
                            }
                        }.padding(.bottom, 10)
                        
                        Section(header: HeaderSectionView(title: "Health",icon: "heart.fill")) {
                            
                            Toggle(isOn: $smoker, label: {
                                Text("Smoker")
                            })
                            .padding(.horizontal)
                            .padding(.vertical,12)
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
                                                checkBirthdayField()
                                            } else {
                                                weightErroMsg = validator.validateField(text: [weight.value], with: [.notEmpty, .isDecimal]) == nil ? "" : validator.validateField(text: [weight.value], with: [.notEmpty, .isDecimal])
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
                                    ErrorMessageComponent(errorMsg: "\(weightErroMsg!)")
                                }
                            }
                            
                            ZStack(alignment: .center) {
                                ZStack(alignment: .trailing) {
                                        TextField("Height", text: $height.value, onEditingChanged: { editingChanged in
                                            if editingChanged {
                                                heightErrorMsg = ""
                                                checkPasswordFields()
                                                checkBirthdayField()
                                            } else {
                                                heightErrorMsg = validator.validateField(text: [height.value], with: [.notEmpty, .isHeight]) == nil ? "" : validator.validateField(text: [height.value], with: [.notEmpty, .isHeight])
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
                                    ErrorMessageComponent(errorMsg: "\(heightErrorMsg!)")
                                }
                            }
                            
                        }.padding(.bottom, 10)
                        
                        Button(action: {
                            submit()
                        }) {
                            Text("Submit")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 330, height: 50)
                                .background(isDisabled() ? Color.gray : Color.blue)
                                .cornerRadius(15.0)
                                .shadow(radius: 10.0, x: 20, y: 10)
                        }
                        .padding([.top,.bottom], 50)
                        .disabled(self.isDisabled())
                        
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
    }
    
    func submit() -> Void {
        
        let smokerData = smoker ? 1 : 0;
        
        var json = [String:Any]()
        json = [
            "firstname": firstname,
            "lastname": lastname,
            "email": email,
            "password": password,
            "confirmedPassword": passwordConfirm,
            "phone": phone.value,
            "gender": genderOptions[selectedGenderIndex],
            "birthday": dateFormatter2.string(from: birthday),
            "smoker": smokerData,
            "height": Int(height.value),
            "weight": Int(weight.value),
            "medical_history": "nothing",
            "family_medical_history": "nothing",
            "treatment": "nothing"
        ]
        UserService.sharedInstance.CreatePatient(endpoint: "api/account", json: json) { (result, success) -> Void in

            if success {
                self.messageTitle = "Success !"
                self.messageContent = "Your Account has been created !"
                self.messageColor = Color.blue
                self.showResponseMessage.toggle()
            } else {
                self.messageTitle = "Error !"
                self.messageContent = "\(result["message"]!)"
                self.messageColor = Color.red
                self.showResponseMessage.toggle()
            }
        }

    }
    
    func isDisabled() -> Bool {
        let enabled = (emailErrorMsg! == "" && email != "") &&
            (firstnameErrorMsg! == "" && firstname != "") &&
            (lastnameErrorMsg! == "" && lastname != "") &&
            (phoneErrorMsg! == "" && phone.value != "") &&
            (passwordErrorMsg! == "" && password != "") &&
            (passwordConfirmErrorMsg! == "" && passwordConfirm != "") &&
            (weightErroMsg! == "" && weight.value != "") &&
            (heightErrorMsg! == "" && height.value != "")
       return !enabled
    }
    
    func checkPasswordFields() -> Void {
        if !firstTapePasswordField {
            passwordErrorMsg = validator.validateField(text: [password], with: [.notEmpty, .passwordlength]) == nil ? "" : validator.validateField(text: [password], with: [.notEmpty, .passwordlength])
        }
        
        if !firstTapePasswordConfirmField {
            passwordConfirmErrorMsg = validator.validateField(text: [passwordConfirm, password], with: [.notEmpty, .validPasswordConfirm]) == nil ? "" :  validator.validateField(text: [passwordConfirm, password], with: [.notEmpty, .validPasswordConfirm])
        }
    }
    
    func checkBirthdayField() -> Void {
        if !firstTapeBirthdayField {
            birthdayErrorMsg = validator.validateField(text: [dateFormatter.string(from: birthday)], with: [.isValidBirthday]) == nil ? "" : validator.validateField(text: [dateFormatter.string(from: birthday)], with: [.isValidBirthday])
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
