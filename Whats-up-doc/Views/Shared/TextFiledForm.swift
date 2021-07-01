//
//  TextFiledForm.swift
//  Whats-up-doc
//
//  Created by Hermance Dornier on 01/07/2021.
//

import SwiftUI

struct TextFiledForm: View {
    let errorMsg: String
    
    var body: some View {
        ZStack(alignment: .center) {
            TextField("Email", text: $email, onEditingChanged: { editingChanged in
                if editingChanged {
                    emailErrorMsg = ""
                    checkPasswordFields()
                    checkBirthdayField()
                } else {
                    emailErrorMsg = validator.validateField(text: [email], with: [.notEmpty, .validEmail]) == nil ? "" : validator.validateField(text: [email], with: [.notEmpty, .validEmail])
                }})
                .padding()
                .background(Color("lightGray"))
                .cornerRadius(20.0)
                .shadow(radius: 10.0, x: 20, y: 10)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            if emailErrorMsg != "" && emailErrorMsg != nil {
                ErrorMessageView(errorMsg: "\(emailErrorMsg!)")
            }
        }
    }
}

struct TextFiledForm_Previews: PreviewProvider {
    static var previews: some View {
        TextFiledForm()
    }
}
