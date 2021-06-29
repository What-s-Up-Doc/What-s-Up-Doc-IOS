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
            if userData.isLoggeIn {
                TabView {
                    HomeView()
                        .tabItem {
                            Text("Home")
                            Image(systemName: "house.fill")
                        }
                    DiagnosticsView()
                        .tabItem {
                            Text("Diagnostics")
                            Image(systemName: "waveform.path.ecg")
                        }
                    AppoinementView()
                        .tabItem {
                            Text("Appoinement")
                            Image(systemName: "calendar")
                        }
                }
            } else {
                NavigationView {
                    LoginView()
                }
            }
        }
    }
}

class UserData: ObservableObject {
    @Published var isLoggeIn: Bool = false
}
