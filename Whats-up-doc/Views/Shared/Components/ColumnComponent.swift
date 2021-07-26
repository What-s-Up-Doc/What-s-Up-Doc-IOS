//
//  ColumnComponent.swift
//  Whats-up-doc
//
//  Created by Marion Mota on 09/07/2021.
//

import SwiftUI

struct ColumnComponent: View{
    let string1: String
    let string2: String
    
    var body: some View {
        HStack(){
            Text(string1).foregroundColor(Color.white)
            Text(string2).foregroundColor(Color.white)
        }
    }
}
