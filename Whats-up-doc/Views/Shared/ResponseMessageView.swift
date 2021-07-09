//
//  ResponseMessageView.swift
//  Whats-up-doc
//
//  Created by Aymeric Larvet on 03/07/2021.
//

import SwiftUI

struct ResponseMessageView: View {
    let title: String
    let message: String
    let color: Color
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color.white)
                Text(message)
                    .font(.subheadline)
                    .foregroundColor(Color.white)
            }
            .padding()
        }
        .padding()
        .background(color)
        .cornerRadius(20.0)
        .shadow(radius: 10.0, x: 20, y: 10)
        .transition(.move(edge: .top))
        .animation((Animation.default))
        .zIndex(1)
    }
}

struct SuccessMessage_Previews: PreviewProvider {
    static var previews: some View {
        ResponseMessageView(title: "Succes !", message: "test", color: Color.blue)
    }
}
