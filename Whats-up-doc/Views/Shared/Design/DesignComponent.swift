//
//  DesignComponent.swift
//  Whats-up-doc
//
//  Created by Etudiant on 06/07/2021.
//

import SwiftUI





extension View {
    
    func pickerDesign() -> some View {
        self.padding(.horizontal)
            .padding(.vertical,12)
            .frame(height: 60)
            .background(Color("lightGray"))
            .cornerRadius(20.0)
            .shadow(radius: 10.0, x: 20, y: 10)
            .padding([.leading, .trailing], 27.5)
    }
    
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
}
