//
//  ErrorMessageView.swift
//  Whats-up-doc
//
//  Created by Aymeric Larvet on 29/06/2021.
//

import SwiftUI

struct ErrorMessageView: View {
    let errorMsg: String
    @State private var animation = false
    @State var numberOfShakes: CGFloat = 0
    
    var body: some View {
        HStack{
            Image(systemName: "exclamationmark.triangle.fill")
            Text(errorMsg)
                .italic()
        }
        .font(.system(size: 14))
        .foregroundColor(.white)
        .padding(3)
        .padding([.trailing, .leading],5)
        .background(Color.red)
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

struct ShakeEffect: AnimatableModifier {
    var shakeNumber: CGFloat = 0

    var animatableData: CGFloat {
        get {
            shakeNumber
        } set {
            shakeNumber = newValue
        }
    }

    func body(content: Content) -> some View {
        content
            .offset(x: sin(shakeNumber * .pi * 2) * 10)
        
    }
}

//struct ErrorMessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ErrorMessageView(errorMsg: "Mon message")
//    }
//}
