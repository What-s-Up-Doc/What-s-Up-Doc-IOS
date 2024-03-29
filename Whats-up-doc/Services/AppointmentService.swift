//
//  UserService.swift
//  Whats-up-doc
//
//  Created by Aymeric Larvet on 04/07/2021.
//

import SwiftUI

class AppointmentService {
    
    static let sharedInstance = AppointmentService()
    
    
    private let urlBase = "https://whats-up-doc.azurewebsites.net/";
    
    func GetMyAllAppointements(endpoint: String, json: [String: Any], completion: @escaping ([String: Any], Bool) -> Void) {
       
        let endpointUrl = URL(string: urlBase + endpoint)!
    
        let data = try! JSONSerialization.data(withJSONObject: json, options: [])
        
        var request = URLRequest(url: endpointUrl)
        request.httpMethod = "Get"
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
                let jsonResponse = try JSONSerialization.jsonObject(with:data, options: []) as? [String: Any]
                guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                    print("Error: HTTP request failed: \(jsonResponse!)")
                    completion(jsonResponse!, false)
                    return
                }
                print("response data:", jsonResponse!)
                
                completion(jsonResponse!, true)
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
                
    }
}
