//
//  ToggleDesign.swift
//  Whats-up-doc
//
//  Created by Etudiant on 06/07/2021.
//

import SwiftUI

extension View {
    func pshychéBackground() -> some View {
        self.foregroundColor(.white)
            .padding()
            .background(Color.yellow)
            .cornerRadius(50)
            .background(Color.red)
            .cornerRadius(20)
            .background(Color.green)
            .cornerRadius(10)
    }
}
