//
//  UserService.swift
//  Whats-up-doc
//
//  Created by Aymeric Larvet on 03/07/2021.
//

import SwiftUI

class DiagnosticService {
    
    static let sharedInstance = DiagnosticService()
    
    private let urlBase = "https://nameless-brushlands-27231.herokuapp.com/";
    
    func getDiagnostic(endpoint: String, json: [String: Any], completion: @escaping ([[String: Any]],Bool) -> Void) {
        
        print(json)
       
        let endpointUrl = URL(string: urlBase + endpoint)!

        let data = try! JSONSerialization.data(withJSONObject: json, options: [])

        var request = URLRequest(url: endpointUrl)
        request.httpMethod = "POST"
        request.httpBody = data
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling POST")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with:data, options: []) as? [[String: Any]]
                guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                    print("Error: HTTP request failed: \(jsonResponse!)")
                    completion(jsonResponse!, false)
                    return
                }
                if jsonResponse != nil {
                    print("response data:", jsonResponse!)
                    completion(jsonResponse!, true)
                } else {
                    print("No reponse data")
                }
                
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
                
    }
}
