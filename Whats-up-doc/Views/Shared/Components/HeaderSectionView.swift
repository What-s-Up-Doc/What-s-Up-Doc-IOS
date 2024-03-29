//
//  HeaderSection.swift
//  Whats-up-doc
//
//  Created by Aymeric Larvet on 01/07/2021.
//

import SwiftUI

struct HeaderSectionView: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack{
            Image(systemName: icon)
            Text(title)
        }
        .font(.title3)
        .foregroundColor(.white)
        .padding(.top,20)
    }
}

struct HeaderSection_Previews: PreviewProvider {
    static var previews: some View {
        HeaderSectionView(title: "Healt",icon: "heart.fill")
    }
}
