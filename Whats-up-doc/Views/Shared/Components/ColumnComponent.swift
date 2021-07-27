//
//  ColumnComponent.swift
//  Whats-up-doc
//
//  Created by Marion Mota on 09/07/2021.
//

import SwiftUI

struct ColumnComponent: View{
    let label: String
    let value: String
    
    var body: some View {
        HStack(){
            Text(label).bold()
            Spacer()
            Text(value)
        }
        .padding()
        .background(Color("lightGray"))
        .cornerRadius(20.0)
        .shadow(radius: 10.0, x: 20, y: 10)
        .disableAutocorrection(true)
        .autocapitalization(.none)
    }
}
