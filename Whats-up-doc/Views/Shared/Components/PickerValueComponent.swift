//
//  PickerValueComponent.swift
//  Whats-up-doc
//
//  Created by Aymeric Larvet on 25/07/2021.
//

import SwiftUI

struct PickerValueComponent: View {
    
    let icon: String
    let title: String
    let pickerValue: String
    @Binding var showPicker: Bool
    
    var body: some View {
        HStack(){
            Image(systemName: icon)
            Text(title)
                .bold()
            Spacer()
            Text("\(pickerValue)")

            Image(systemName: showPicker ? "chevron.up" : "chevron.down")
                .resizable()
                .frame(width:13, height: 6)
                .foregroundColor(.black)
        }.pickerInputDesign()
        .onTapGesture {
            self.showPicker.toggle()
        }
    }
}

//struct PickerValueComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        PickerValueComponent()
//    }
//}
