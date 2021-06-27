//
//  LoginView.swift
//  Whats-up-doc
//
//  Created by Hermance Dornier on 27/06/2021.
//

import SwiftUI

struct LoginView: View {

    @State private var email = ""
    @State private var password = ""
    @State private var showPassword: Bool = false
    

    var body: some View {
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
                TextField("Email", text: self.$email)
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
                        Image(systemName: self.showPassword ? "eye.slash" : "eye")
                            .accentColor(.black).scaleEffect(0.8).padding()
                    }
                }
            }.padding([.leading, .trailing], 27.5)
            
            Button(action: {}) {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 330, height: 50)
                    .background(Color.blue)
                    .cornerRadius(15.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
            }.padding(.top, 50)
            
            Spacer()
            HStack(spacing: 0) {
                Text("Don't have an account? ")
                Button(action: {}) {
                    Text("Sign Up")
                        .foregroundColor(.black)
                }
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.green, .white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct OvalTextFieldStyle: TextFieldStyle {
    let skyBlue = Color(hue: 0.1639, saturation: 1, brightness: 1)
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(Color.white)
            .cornerRadius(20)
           
    }
}
