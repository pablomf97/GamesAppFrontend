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
        // let url = URL(string: "http://127.0.0.1:8000/user/login")!
        
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
    
    func logout(onComplete: @escaping (Any?) -> Void) {
        // For testing use:
        // let url = URL(string: "http://127.0.0.1:8000/user/logout")!
        
        // On production use:
        let url = URL(string: baseUrl + "user/logout/")!
        var request = URLRequest(url: url)
                
        guard let token = UserDefaults.init().string(forKey: "token") else {
            onComplete([])
            return
        }
        
        request.httpMethod = "GET"
        request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                // Handle HTTP request error
                onComplete(error)
            } else if let data = data {
                // Handle HTTP request response
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    onComplete(responseJSON["message"])
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
        // let url = URL(string: "http://127.0.0.1:8000/user/register")!
        
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
        // let url = URL(string: "http://127.0.0.1:8000/games/top-25")!
        
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
        // let url = URL(string: "http://127.0.0.1:8000/games/game")!
        
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
        // let url = URL(string: "http://127.0.0.1:8000/games/game/offers")!
        
        // On production use:
        let url = URL(string: baseUrl + "games/game/offers")!
        
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
        // let url = URL(string: "http://127.0.0.1:8000/news/\(type.rawValue)")!
        
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
    
    func isFavourite(gameId: String, onComplete: @escaping (Bool?) -> Void) {
        // For testing use:
        // let url = URL(string: "http://127.0.0.1:8000/user/is-favourited/\(gameId)/")!
        
        // On production use:
        let url = URL(string: baseUrl + "user/is-favourited/\(gameId)/")!
        
        var request = URLRequest(url: url)

        guard let token = UserDefaults.init().string(forKey: "token") else {
            onComplete(nil)
            return
        }
        
        request.httpMethod = "GET"
        request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
        
        // TODO: Check if game is favourited
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

                let isFavourited = responseJSON["is_favourited"] as? Bool
                onComplete(isFavourited)
            } else {
                // Handle unexpected error
                onComplete(nil)
            }
        }.resume()
    }
    
    func addGameToFavourites(gameId: String, onComplete: @escaping (Bool?) -> Void) {
        // For testing use:
        // let url = URL(string: "http://127.0.0.1:8000/user/add-game/\(gameId)/")!
        
        // On production use:
        let url = URL(string: baseUrl + "user/add-game/\(gameId)/")!
        
        var request = URLRequest(url: url)

        guard let token = UserDefaults.init().string(forKey: "token") else {
            onComplete(nil)
            return
        }
        
        request.httpMethod = "GET"
        request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
        
        // TODO: Check if game is favourited
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

                let message = responseJSON["message"] as! String
                if message == "Game successfully added to saved games." {
                    onComplete(true)
                } else {
                    onComplete(nil)
                }
            } else {
                // Handle unexpected error
                onComplete(nil)
            }
        }.resume()
    }
    
    func removeGameFromFavourites(gameId: String, onComplete: @escaping (Bool?) -> Void) {
        // For testing use:
        // let url = URL(string: "http://127.0.0.1:8000/user/remove-game/\(gameId)/")!
        
        // On production use:
        let url = URL(string: baseUrl + "user/remove-game/\(gameId)/")!
        
        var request = URLRequest(url: url)

        guard let token = UserDefaults.init().string(forKey: "token") else {
            onComplete(nil)
            return
        }
        
        request.httpMethod = "GET"
        request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
        
        // TODO: Check if game is favourited
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

                let success = responseJSON["success"] as? Bool
                onComplete(success)
            } else {
                // Handle unexpected error
                onComplete(nil)
            }
        }.resume()
    }
    
    func searchGames(gameName: String, onComplete: @escaping ([GameListItem]) -> Void) {
        // For testing use:
        // let url = URL(string: "http://127.0.0.1:8000/user/get-games/")!
        
        // On production use:
        let url = URL(string: baseUrl + "games/search/\(gameName)")!
        
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
                if let responseJSON = responseJSON as? [String: Any] {
                    guard let response = responseJSON["search_results"] as? [[String: Any]] else {
                        onComplete([])
                        return
                    }
                    var games: [GameListItem] = []
                    
                    for JSONObject in response {
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
    
    func getMyGames(next: String?, previous: String?, onComplete: @escaping ([Game], String?, String?) -> Void) {
        let requestUrl: String
        if let next = next {
            requestUrl = next
        } else if let previous = previous {
            requestUrl = previous
        } else {
            requestUrl = baseUrl + "user/get-games/"
        }
        
        // For testing use:
        // let url = URL(string: "http://127.0.0.1:8000/user/get-games/")!
        
        // On production use:
        let url = URL(string: requestUrl)!
        
        var request = URLRequest(url: url)
        
        guard let token = UserDefaults.init().string(forKey: "token") else {
            onComplete([], nil, nil)
            return
        }
        
        request.httpMethod = "GET"
        request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                // Handle HTTP request error
                onComplete([], nil, nil)
            } else if let data = data {
                // Handle HTTP request response
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    guard let response = responseJSON["results"] as? [[String: Any]] else {
                        onComplete([], nil, nil)
                        return
                    }
                    var games: [Game] = []
                    
                    for JSONObject in response {
                        games.append(Game(JSONObject))
                    }
                    
                    let next = responseJSON["next"] as? String
                    let previous = responseJSON["previous"] as? String

                    onComplete(games, next, previous)
                } else {
                    onComplete([], nil, nil)
                }
            } else {
                // Handle unexpected error
                onComplete([], nil, nil)
            }
        }.resume()
    }
}
