//
//  LoginView.swift
//  Whats-up-doc
//
//  Created by Aymeric Larvet on 27/06/2021.
//

import SwiftUI
import Combine

struct LoginView: View {
    
    @EnvironmentObject  var userData: UserData

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var messageTitle: String = ""
    @State private var messageContent: String = ""
    @State private var showResponseMessage = false
    @State private var messageColor: Color = Color.red
    

    var body: some View {
        ZStack(alignment: .top){
            if showResponseMessage {
                ResponseMessageComponent(title: messageTitle, message: messageContent,color: messageColor)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            self.showResponseMessage = false
                        }
                    }
            }
            VStack() {

                Text("What's up Doc")
                    .font(.largeTitle).foregroundColor(Color.white)
                    .padding([.top, .bottom], 40)
                    .shadow(radius: 10.0, x: 20, y: 10)
                
                Image("logo")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .padding(.bottom, 100)
                
                VStack(alignment: .leading, spacing: 15) {
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color("lightGray"))
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    
                    ZStack(alignment: .trailing) {
                        if showPassword {
                            TextField("Password", text: $password)
                                .padding()
                                .background(Color("lightGray"))
                                .cornerRadius(20.0)
                                .shadow(radius: 10.0, x: 20, y: 10)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                            
                        } else {
                            SecureField("Password", text: $password)
                                    .padding()
                                    .background(Color("lightGray"))
                                    .cornerRadius(20.0)
                                    .shadow(radius: 10.0, x: 20, y: 10)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                            
                        }
                        Button(action: {
                            showPassword.toggle()
                        }) {
                            Image(systemName: showPassword ? "eye.slash" : "eye")
                                .accentColor(Color("primary")).scaleEffect(0.8).padding()
                        }
                    }
                }.padding([.leading, .trailing], 27.5)
                
                Button(action: {
                    submitLogin()
                }) {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 330, height: 50)
                        .background(isDisabled() ? Color.gray : Color.blue)
                        .cornerRadius(15.0)
                        .shadow(radius: 10.0, x: 20, y: 10)

                }.padding(.top, 50)
                .disabled(isDisabled())
                
                Spacer()
                    HStack(spacing: 0) {
                        Text("Don't have an account? ")
                        NavigationLink(destination: RegisterView()){
                            Text("Sign Up")
                        }.navigationBarTitle("Login", displayMode: .inline)
                }.padding(.bottom)
            }.background(
                LinearGradient(gradient: Gradient(colors: [.green, Color("lightGray")]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all))
            
            
        }
       
        
    }
    func isDisabled() -> Bool {
        return email == "" || password == ""
    }
    
    func submitLogin() -> Void {
        var json = [String:Any]()
        json = [
            "email": email,
            "password": password
        ]
        
        UserService.sharedInstance.Login(endpoint: "api/login", json: json) { (result, success) -> Void in
            if success {
                print("User logged !")
                setToken(token: result)
                userData.updateIsLoggedIn()
            } else {
                self.messageTitle = "Error !"
//                self.messageContent = "\(result["message"]!)"
                self.showResponseMessage.toggle()
            }
        }
    }
    
    func setToken(token: String) {
        UserDefaults.standard.set(token, forKey:"token")
    }
    

}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
