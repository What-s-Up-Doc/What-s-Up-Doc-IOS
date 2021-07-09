//
//  DesignComponent.swift
//  Whats-up-doc
//
//  Created by Etudiant on 06/07/2021.
//

import SwiftUI


extension View {
    
    func toggleDesign() -> some View {
        self.padding(.horizontal)
            .padding(.vertical,12)
            .background(Color("lightGray"))
            .cornerRadius(20.0)
            .shadow(radius: 10.0, x: 20, y: 10)
            .toggleStyle(SwitchToggleStyle(tint: Color.blue))
    }
    
    func buttonTextDesign() -> some View {
        self.font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 330, height: 50)
    }
    
    func backgroundDesign() -> some View{
        self.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .center
          )
        .background(
            LinearGradient(gradient: Gradient(colors: [.green, Color("lightGray")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
    }
    
    func textButtonNotDisabled(color: Color) -> some View{
        self.font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(color)
            .cornerRadius(10)
            .shadow(radius: 10.0, x: 20, y: 10)
    }
}
