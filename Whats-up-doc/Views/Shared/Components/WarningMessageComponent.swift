//
//  WarningMessageComponent.swift
//  Whats-up-doc
//
//  Created by Hermance Dornier on 25/07/2021.
//

import SwiftUI

struct WarningMessageComponent: View {
    let warningMsg: String
    @State private var animation = false
    @State var numberOfShakes: CGFloat = 0
    
    var body: some View {
        HStack{
            Image(systemName: "exclamationmark.triangle.fill")
            Text(warningMsg)
                .italic()
        }
        .font(.system(size: 14))
        .foregroundColor(.white)
        .padding(3)
        .padding([.trailing, .leading],5)
        .background(Color.yellow)
        .cornerRadius(20.0)
        .padding(.top, 45)
        .modifier(ShakeEffect(shakeNumber: numberOfShakes))
        .onAppear {
            withAnimation(.easeIn(duration: 0.6)) {
                numberOfShakes = 2
            }
        }
    }
}

//struct WarningMessageComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        WarningMessageComponent()
//    }
//}
