//
//  Models.swift
//  VGSmasher
//
//  Created by Pablo Figueroa Martínez on 3/6/21.
//

import Foundation

struct Game: Identifiable, Codable {
    let id: String
    let name: String
    let releaseDate: String
    let officialWebsite: String
    let developer: String
    let publisher: String
    let platforms: String
    let pegi: String
    let tags: String
    let description: String
    let imageUrl: String
    let pageUrl: String
    let userRating: String
    let mediaRating: String
    
    init(_ dictionary: [String: Any]) {
        id = dictionary["id"] as? String ?? ""
        name = dictionary["name"] as? String ?? ""
        releaseDate = dictionary["release_date"] as? String ?? ""
        officialWebsite = dictionary["official_website"] as? String ?? ""
        developer = dictionary["developer"] as? String ?? ""
        publisher = dictionary["publisher"] as? String ?? ""
        platforms = dictionary["platforms"] as? String ?? ""
        pegi = dictionary["pegi"] as? String ?? ""
        tags = dictionary["tags"] as? String ?? ""
        description = dictionary["description"] as? String ?? ""
        imageUrl = dictionary["image_url"] as? String ?? ""
        pageUrl = dictionary["page_url"] as? String ?? ""
        userRating = dictionary["user_rating"] as? String ?? ""
        mediaRating = dictionary["media_rating"] as? String ?? ""
    }
}

struct GameListItem: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let info: String
    let merchant: String
    let price: String
    let href: String
    
    init(_ dictionary: [String: Any]) {
        id = UUID()
        name = dictionary["name"] as? String ?? ""
        info = dictionary["info"] as? String ?? ""
        merchant = dictionary["merchant"] as? String ?? ""
        price = dictionary["price"] as? String ?? ""
        href = dictionary["href"] as? String ?? ""
    }
}

struct OfferRowItem: Identifiable, Codable, Hashable {
    let id: UUID
    let shop: String
    let platform: String
    let edition: String
    let priceBeforeFees: String
    let shopUrl: String
    
    init(_ dictionary: [String: Any]) {
        id = UUID()
        shop = dictionary["shop"] as? String ?? ""
        platform = dictionary["platform"] as? String ?? ""
        edition = dictionary["edition"] as? String ?? ""
        priceBeforeFees = dictionary["price_before_fees"] as? String ?? ""
        shopUrl = dictionary["shop_url"] as? String ?? ""
    }
}
