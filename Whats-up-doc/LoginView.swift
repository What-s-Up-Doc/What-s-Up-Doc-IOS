//
//  LoginView.swift
//  Whats-up-doc
//
//  Created by Hermance Dornier on 27/06/2021.
//

import SwiftUI

struct LoginView: View {
    
    @State var login = ""
    @State var password = ""
    @State private var showPassword: Bool = false
    
    var body: some View {
    VStack(alignment: .leading) {
                    Text("Login").font(.title2)
                    HStack {
                        TextField("Email", text: $login)
                    }
                    .textFieldStyle(OvalTextFieldStyle())
        
                    Text("Password").font(.title2)
                    ZStack(alignment: .trailing) {
                        if showPassword {
                            TextField("Password", text: $password)
                        } else {
                            SecureField("Password", text: $password)
                        }
                        Button(action: {
                            showPassword.toggle()
                        }) {
                            Image(systemName: self.showPassword ? "eye" : "eye.slash")
                                .accentColor(.gray).scaleEffect(0.8).padding()
                        }
                    }.textFieldStyle(OvalTextFieldStyle())
    }
    .padding()
    .background(Color("Blue"))
    .cornerRadius(10.0)
    .shadow(color: .gray, radius: 5, x: 3, y: 5)
    .padding()
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
