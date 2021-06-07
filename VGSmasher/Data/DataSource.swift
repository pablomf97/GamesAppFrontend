//
//  DataSource.swift
//  VGSmasher
//
//  Created by Pablo Figueroa Martínez on 2/6/21.
//

import Foundation

class DataSource {
    
    internal let baseUrl = "https://vgsmasher-backend.ew.r.appspot.com/"
    
    func login(username: String, password: String, onComplete: @escaping (Any?) -> Void) {
        // For testing use:
        // let url = URL(string: "http://127.0.0.1:8000/" + "user/login")!
        
        // On production use:
        let url = URL(string: baseUrl + "user/login/")!
        var request = URLRequest(url: url)
        
        let body = ["username": username, "password": password]
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
    
    func register(username: String, email: String, password: String, password2: String, onComplete: @escaping (Any?) -> Void) {
        // For testing use:
        // let url = URL(string: "http://127.0.0.1:8000/" + "user/register")!
        
        // On production use:
        let url = URL(string: baseUrl + "user/register/")!
        var request = URLRequest(url: url)
        
        let body = ["username": username, "email": email, "password": password, "password2": password2]
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
    
    func getTopGames(onComplete: @escaping ([GameListItem]) -> Void) {
        // For testing use:
        // let url = URL(string: "http://127.0.0.1:8000/" + "games/top-25")!
        
        // On production use:
        let url = URL(string: baseUrl + "games/top-25")!
        var request = URLRequest(url: url)
        
        guard let token = UserDefaults.init().string(forKey: "token") else {
            onComplete([])
            return
        }
        
        request.httpMethod = "GET"
        request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                // Handle HTTP request error
                onComplete([])
            } else if let data = data {
                // Handle HTTP request response
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [[String: Any]] {
                    var games: [GameListItem] = []
                    for JSONObject in responseJSON {
                        games.append(GameListItem(JSONObject))
                    }
                    
                    onComplete(games)
                } else {
                    onComplete([])
                }
            } else {
                // Handle unexpected error
                onComplete([])
            }
        }.resume()
    }
    
    func getGameByUrl(game_url: String, onComplete: @escaping (Game?) -> Void) {
        // For testing use:
        // let url = URL(string: "http://127.0.0.1:8000/" + "games/game")!
        
        // On production use:
        let url = URL(string: baseUrl + "games/game")!
        var request = URLRequest(url: url)

        guard let token = UserDefaults.init().string(forKey: "token") else {
            onComplete(nil)
            return
        }
        
        request.httpMethod = "POST"
        request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")

        let body = ["game_href": game_url]
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                // Handle HTTP request error
                onComplete(nil)
            } else if let data = data {
                // Handle HTTP request response
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                guard let responseJSON = responseJSON as? [String: Any] else {
                    onComplete(nil)
                    return
                }

                onComplete(Game(responseJSON))
            } else {
                // Handle unexpected error
                onComplete(nil)
            }
        }.resume()
    }
    
    func getGameOffersByUrl(game_url: String, onComplete: @escaping ([OfferRowItem]) -> Void) {
        // For testing use:
        // let url = URL(string: "http://127.0.0.1:8000/" + "games/game/offers")!
        
        // On production use:
        let url = URL(string: baseUrl + "games/game")!
        
        var request = URLRequest(url: url)

        guard let token = UserDefaults.init().string(forKey: "token") else {
            onComplete([])
            return
        }
        
        request.httpMethod = "POST"
        request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")

        let body = ["game_url": game_url]
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                // Handle HTTP request error
                onComplete([])
            } else if let data = data {
                // Handle HTTP request response
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                guard let responseJSON = responseJSON as? [[String: Any]] else {
                    onComplete([])
                    return
                }

                var offers: [OfferRowItem] = []
                for offer in responseJSON {
                    offers.append(OfferRowItem(offer))
                }
                onComplete(offers)
            } else {
                // Handle unexpected error
                onComplete([])
            }
        }.resume()
    }
    
    func getNews(_ type: NewsRowItem.NewsType , onComplete: @escaping ([NewsRowItem]) -> Void) {
        // For testing use:
        // let url = URL(string: "http://127.0.0.1:8000/" + "games/game/offers")!
        
        // On production use:
        let url = URL(string: baseUrl + "news/\(type.rawValue)")!
        
        var request = URLRequest(url: url)

        guard let token = UserDefaults.init().string(forKey: "token") else {
            onComplete([])
            return
        }
        
        request.httpMethod = "GET"
        request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                // Handle HTTP request error
                onComplete([])
            } else if let data = data {
                // Handle HTTP request response
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                guard let responseJSON = responseJSON as? [[String: Any]] else {
                    onComplete([])
                    return
                }

                var news: [NewsRowItem] = []
                for newsPiece in responseJSON {
                    news.append(NewsRowItem(newsPiece))
                }
                onComplete(news)
            } else {
                // Handle unexpected error
                onComplete([])
            }
        }.resume()
    }
}
