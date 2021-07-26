//
//  Whats_up_docApp.swift
//  Whats-up-doc
//
//  Created by Etudiant on 11/06/2021.
//

import SwiftUI

@main
struct Whats_up_docApp: App {
    
    @StateObject private var userData: UserData = UserData()
    
    var body: some Scene {
        WindowGroup {
            
            TabView {
                DiagnosticsView()
                    .tabItem {
                        Text("Diagnostics")
                        Image(systemName: "waveform.path.ecg")
                    }
                AppointmentView()
                    .tabItem {
                        Text("Appointments")
                        Image(systemName: "calendar")
                    }
                if userData.isLoggedIn {
                    AccountView()
                        .tabItem {
                            Text("Profile")
                            Image(systemName: "person.circle.fill")
                        }
                }
            }.environmentObject(userData)
        }
    }
}

func isUserLoggedIN() -> Bool {
    let str = UserDefaults.standard.object(forKey: "token") == nil ? "" : UserDefaults.standard.object(forKey: "token") as! String
    return str.count > 0 ? true : false
}

class UserData: ObservableObject {
    @Published var isLoggedIn: Bool = isUserLoggedIN()
    
    func updateIsLoggedIn (){
        isLoggedIn = isUserLoggedIN()
    }
    
    func logout (){
        UserDefaults.standard.set(nil, forKey: "token")
        isLoggedIn = false
    }
}
