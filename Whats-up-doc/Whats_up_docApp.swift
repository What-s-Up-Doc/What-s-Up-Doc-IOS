//
//  Whats_up_docApp.swift
//  Whats-up-doc
//
//  Created by Etudiant on 11/06/2021.
//

import SwiftUI

@main
struct Whats_up_docApp: App {
    var body: some Scene {
         WindowGroup {
            TabView {
                registerView()
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
        }
    }
}
