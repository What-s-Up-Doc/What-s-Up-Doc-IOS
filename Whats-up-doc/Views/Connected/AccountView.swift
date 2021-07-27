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
    @State private var isLoading: Bool = false
    
    var body: some View {
        LoadingComponent(isShowing: self.$isLoading) {
            ZStack(alignment: .top){
                VStack() {
                    HeaderComponent()
                    ScrollView{
                        VStack(alignment: .leading) {
                            Section(header: HeaderSectionView(title: "Account",icon: "person.crop.circle.fill")) {
                                ColumnComponent(label: "Email", value: user.email)
                            }
                            
                            Section(header: HeaderSectionView(title: "Personal",icon: "person.fill")) {
                                ColumnComponent(label: "Gender", value: user.gender)
                                ColumnComponent(label: "Firstname", value: user.firstname)
                                ColumnComponent(label: "Lastname", value: user.lastname)
                                ColumnComponent(label: "Birthday", value: user.birthday)
                                ColumnComponent(label: "Phone", value: user.phone)
                            }
                            
                            Section(header: HeaderSectionView(title: "Health",icon: "heart.fill")) {
                                ColumnComponent(label: "Smoker", value: user.smokerString())
                                ColumnComponent(label: "Height", value: String(user.height))
                                ColumnComponent(label: "Weight", value: String(user.weight))
                            }
                            Spacer()
                        }.padding(.horizontal)
                    }
                    Button(action: {
                        self.showButton.toggle()
                    }) {
                        Text("Logout")
                            .buttonTextDesign()
                            .background(Color.red)
                            .cornerRadius(15.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                    }
                    .actionSheet(isPresented: $showButton){
                        ActionSheet(title: Text("Logout"), message: Text ("Are your sure ?"),
                                    buttons: [.destructive(Text("Yes"), action: {
                                        self.isLoading.toggle()
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                            userData.logout()
                                            userData.updateIsLoggedIn()
                                        }
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




