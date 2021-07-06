//
//  ToggleComponent.swift
//  Whats-up-doc
//
//  Created by Etudiant on 06/07/2021.
//

import SwiftUI

struct ToggleComponent: View {
    @Binding var isChecked: Bool
    let title: String
    
    var body: some View {
        Toggle(isOn: $isChecked, label: {
            Text(title)
        }).toggleDesign()
    }
}

//struct ToggleSymptom: View {
//    @Binding var i
//    let symptom: SymptomItem
//    
//    var body: some View {
//        Toggle(isOn: symptom.isChecked, label: {
//            Text(symptom.name)
//        }).toggleDesign()
//    }
//}
