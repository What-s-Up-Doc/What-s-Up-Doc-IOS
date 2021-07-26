//
//  Patient.swift
//  Whats-up-doc
//
//  Created by Marion Mota on 09/07/2021.
//

import SwiftUI

class User {
    init(firstname: String, lastname: String, email: String, phone: String, gender: String, birthday: String, smoker: Int, height: Double, weight: Double, medicalHistory: String, treatment: String, familyMedicalHistory: String) {
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.phone = phone
        self.gender = gender
        self.birthday = birthday
        self.smoker = smoker
        self.height = height
        self.weight = weight
        self.medicalHistory = medicalHistory
        self.familyMedicalHistory = familyMedicalHistory
        self.treatment = treatment
    }
    
    var firstname: String
    var lastname: String
    var email: String
    var phone: String
    var gender: String
    var birthday: String
    var smoker: Int
    var height: Double
    var weight: Double
    var medicalHistory: String
    var treatment: String
    var familyMedicalHistory: String
    
    func smokerString() -> String{
        return self.smoker == 1 ? "Yes": "No"
    }
    
}

func mockUser() -> User{
    return User(firstname: "blopblop",lastname: "blop",email: "teFbvfvvyhths@gmail.com",phone: "01928384732",gender: "male",birthday: "1993-12-23",smoker: 1,height: 64.3,weight: 54.5,medicalHistory: "nothing",treatment: "nothing", familyMedicalHistory: "nothing")
}


