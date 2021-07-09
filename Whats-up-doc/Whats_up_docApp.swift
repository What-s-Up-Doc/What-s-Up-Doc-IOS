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
            }
        }
    }
}

class UserData: ObservableObject {
    @Published var isLoggedIn: Bool = false
}
