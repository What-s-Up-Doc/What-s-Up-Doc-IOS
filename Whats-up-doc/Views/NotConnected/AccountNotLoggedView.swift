//
//  AccountNotLoggedView.swift
//  Whats-up-doc
//
//  Created by Hermance Dornier on 26/07/2021.
//

import SwiftUI

struct AccountNotLoggedView: View {
    var body: some View {
        ZStack(alignment: .top){
            VStack() {
                HeaderComponent()
                Spacer()
                Text("You must be connected to take an appointment.")
                HStack {
                    Text("Please ")
                    NavigationLink(destination: LoginView()){
                        Text("login")
                    }
                }
                HStack(spacing: 0) {
                    Text("Don't have an account? ")
                    NavigationLink(destination: RegisterView()){
                        Text("Sign Up")
                    }//.navigationBarTitle("Login", displayMode: .inline)
                }
                Spacer()

            }.frame(
                minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,
                maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,
                maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/
            )
            .background(
                LinearGradient(gradient: Gradient(colors: [.green, Color("lightGray")]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all))
        }
    }
}

struct AccountNotLoggedView_Previews: PreviewProvider {
    static var previews: some View {
        AccountNotLoggedView()
    }
}
