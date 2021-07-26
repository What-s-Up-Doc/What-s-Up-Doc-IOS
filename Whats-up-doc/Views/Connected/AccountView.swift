//
//  UserView.swift
//  Whats-up-doc
//
//  Created by Marion Mota on 09/07/2021.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject  var userData: UserData
    @State private var showButton: Bool = false
    @State private var user: User = mockUser()
    
    var body: some View {
        ZStack(alignment: .top){
            ScrollView{
                VStack() {
                    HeaderComponent()
                    
                    Section(header: HeaderSectionView(title: "Account",icon: "heart.fill")) {}
                    
                    Spacer()
                    VStack(alignment: .leading) {
                        Group {
                            ColumnComponent(string1: "Firstname", string2: user.firstname)
                            ColumnComponent(string1: "Lastname", string2: user.lastname)
                            ColumnComponent(string1: "Email", string2: user.email)
                            ColumnComponent(string1: "Birthday", string2: user.birthday)
                            ColumnComponent(string1: "Gender", string2: user.gender)
                            ColumnComponent(string1: "Smoker", string2: user.smokerString())
                            ColumnComponent(string1: "Height", string2: String(user.height))
                        }
                        
                        Group {

                            ColumnComponent(string1: "Weight", string2: String(user.weight))
                            ColumnComponent(string1: "Medical History", string2: String(user.medicalHistory))
                            ColumnComponent(string1: "Family Medical History", string2: String(user.familyMedicalHistory))
                            ColumnComponent(string1: "Treatment", string2: String(user.treatment))
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        self.showButton.toggle()
                    }) {
                        Text("Settings")
                    }.textButtonNotDisabled(color: Color.blue)
                    .actionSheet(isPresented: $showButton){
                        ActionSheet(title: Text("Account manager"), message: Text ("Manage your account here"),
                                    buttons: [ .default(Text("Modify Account information"), action: {
                                        
                                    }), .destructive(Text("Logout"), action: {
                                        userData.logout()
                                }), .cancel()])
                    }
                    
                    Spacer()
                }.backgroundDesign()
            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}




