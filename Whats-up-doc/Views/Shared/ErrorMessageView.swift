//
//  ErrorMessageView.swift
//  Whats-up-doc
//
//  Created by Hermance Dornier on 29/06/2021.
//

import SwiftUI

struct ErrorMessageView: View {
    let errorMsg: String
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
    }
}

//struct ErrorMessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ErrorMessageView(errorMsg: "Mon message")
//    }
//}
