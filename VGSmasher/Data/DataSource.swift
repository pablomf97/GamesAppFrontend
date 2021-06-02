//
//  DataSource.swift
//  VGSmasher
//
//  Created by Pablo Figueroa Martínez on 2/6/21.
//

import Foundation

class DataSource {
    
    internal let baseUrl = "https://vgsmasher-backend.ew.r.appspot.com/"
    
    func login(username: String, password: String, onComplete: @escaping (Any?) -> ()) {
        let url = URL(string: baseUrl + "user/login/")!
        var request = URLRequest(url: url)
        
        let body = ["username": username, "password": password]
        // NOT LIKE THIS
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                // Handle HTTP request error
                onComplete(error)
            } else if let data = data {
                // Handle HTTP request response
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    onComplete(responseJSON["token"])
                } else {
                    onComplete(nil)
                }
            } else {
                // Handle unexpected error
                onComplete(nil)
            }
        }.resume()
    }
    
}
