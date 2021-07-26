//
//  AppointmentView.swift
//  Whats-up-doc
//
//  Created by Aymeric Larvet on 27/06/2021.
//

import SwiftUI

struct AppointmentView: View {
    @EnvironmentObject private var userData: UserData
    
    var body: some View {
        if userData.isLoggedIn {
            AppointmentLoggedView()
        } else {
            NavigationView {
                AppointmentNotLoggedView()
            }
        }
    }
}

struct AppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentView()
    }
}
