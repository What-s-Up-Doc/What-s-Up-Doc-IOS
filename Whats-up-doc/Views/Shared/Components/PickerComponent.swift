//
//  PickerComponent.swift
//  Whats-up-doc
//
//  Created by Aymeric Larvet on 25/07/2021.
//

import SwiftUI

struct PickerComponent: View {
    @Binding var pickerIndex: Int
    let pickerList: [Item]
    
    var body: some View{
        HStack(){
            Picker("Speciality", selection: $pickerIndex, content: {
                ForEach(0..<pickerList.count, content: { index in
                    Text(pickerList[index].name)
                })
            }).animation(.default)
        }.pickerDesign()
    }
}

//struct PickerComponent_Previews: PreviewProvider {
//    @Binding var pickerIndex: Int
//    let pickerList: [Item] = [id: 1, name: "TEST"]
//    static var previews: some View {
//        PickerComponent(pickerIndex: pickerIndex, pickerList: pickerList)
//    }
//}
