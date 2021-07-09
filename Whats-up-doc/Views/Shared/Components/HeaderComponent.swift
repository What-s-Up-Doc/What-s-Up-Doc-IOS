//
//  HeaderComponent.swift
//  Whats-up-doc
//
//  Created by Etudiant on 06/07/2021.
//

import SwiftUI

struct HeaderComponent: View {
    
    var body: some View {
        Text("What's up Doc")
            .font(.largeTitle).foregroundColor(Color.white)
            .padding([.top, .bottom], 15)
            .shadow(radius: 10.0, x: 20, y: 10)
        
        Image("logo")
            .resizable()
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10.0, x: 20, y: 10)
            .padding(.bottom, 20)
    }
}

