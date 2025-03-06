//
//  RecipeResponse.swift
//  RecipeDisplayApp
//
//  Created by apple on 2/27/25.
//

import Foundation
struct RecipeResponse : Codable {
    let recipes : [Recipe]
}

struct Recipe : Codable, Identifiable, Equatable {
    let cuisine : String
    let name : String
    let id : String
    let photo_url_small : String
    
    enum CodingKeys: String, CodingKey {
        case cuisine = "cuisine"
        case name = "name"
        case id = "uuid"
        case photo_url_small = "photo_url_small"
    }
}
