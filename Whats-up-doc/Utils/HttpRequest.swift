//
//  HttpRequest.swift
//  Whats-up-doc
//
//  Created by Hermance Dornier on 03/07/2021.
//

import SwiftUI

class HttpRequest {
    static let sharedInstance = HttpRequest()
    
    private let urlBase = "https://whats-up-doc.azurewebsites.net/";
    
    func post(endpoint: String, json: [String: Any]) -> Void {
       
        let endpointUrl = URL(string: urlBase + endpoint)!
        
        do {
            
            let data = try! JSONSerialization.data(withJSONObject: json, options: [])
                        
            var request = URLRequest(url: endpointUrl)
            request.httpMethod = "POST"
            request.httpBody = data
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")

            let task = URLSession.shared.dataTask(with: request)
            if (json["response"]) != nil {
                                    print("1234")
            }
            
            
            task.resume()
            
        } catch  {
            //TODO
            print(error)
        }
        
    }
}
