//
//  BottomSheet.swift
//  Whats-up-doc
//
//  Created by Hermance Dornier on 30/06/2021.
//

import SwiftUI

struct DatePickerSheet: View {
    @State var birthday = Date()
    var body: some View {
        VStack(spacing: 15){
            DatePicker("", selection: $birthday, displayedComponents: .date)
                .datePickerStyle(WheelDatePickerStyle())
        }
        .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerSheet()
    }
}
