//
//  ValidatorField.swift
//  Whats-up-doc
//
//  Created by Aymeric Larvet on 29/06/2021.
//

import SwiftUI

class Validator {
    func validateField(text: [String], with rules: [Rule]) -> String? {
        return rules.compactMap({ $0.check(text) }).first
    }
}

struct Rule {
    // Return nil if matches, error message otherwise
    let check: ([String]) -> String?

    static let notEmpty = Rule(check: {
        return $0[0].isEmpty ? "Must not be empty" : nil
    })

    static let validEmail = Rule(check: {
        let regex = #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}"#

        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: $0[0]) ? nil : "Must have valid email"
    })
    
    static let validPhone = Rule(check: {
        let regex = #"(?:(?:\+|00)33|0)\s*[1-9](?:[\s.-]*\d{2}){4}"#


        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: $0[0]) ? nil : "Must have valid phone number"
    })
    
    static let fieldlenght = Rule(check: {
        return $0[0].count > 1 && $0[0].count < 20 ? nil : "Must contain between 2 and 20 characters"
    })
    
    static let passwordlength = Rule(check: {
        return $0[0].count > 4 && $0[0].count < 20 ? nil : "Must contain between 5 and 20 characters"
    })
    
    static let validPasswordConfirm = Rule(check: {
        return $0[0] == $0[1] ? nil : "Must match witch password"
    })
    
    static let isDecimal = Rule(check: {
        let regex = #"^[0-9]{1,3}.?[0-9]{0,2}"#

        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: $0[0]) ? nil : "Must have valid format"
    })
    
    static let isHeight = Rule(check: {
        let regex = #"^[0-9]{1,3}"#

        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: $0[0]) ? nil : "Must have valid format"
    })
    
    static let isValidBirthday = Rule(check: {
        
        print("Date",$0[0])
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        var date = dateFormatter.date(from: $0[0])

        if date == nil {
            return "Error"
        }
        return  date! < Date() ? nil : "Must have valid birthday"
    })

    static let countryCode = Rule(check: {
        let regex = #"^\+\d+.*"#

        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: $0[0]) ? nil : "Must have prefix country code"
    })
}
