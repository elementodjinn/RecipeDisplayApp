//
//  RecipeService.swift
//  RecipeDisplayApp
//
//  Created by apple on 2/27/25.
//

import Foundation
import Combine
import SwiftUI

protocol RecipeServiceProtocol {
    func fetchRecipes() async throws -> [Recipe]
    func fetchRecipeImage(_ urlString : String?) async throws -> UIImage
}

enum APIError : Error {
    case invalidResponse
    case invalidURL
    case invalidData
}

class RecipeService : RecipeServiceProtocol, ObservableObject {
    let baseURL : String
    init(_ url: String = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"){
        baseURL = url
    }
    var cancellable = Set<AnyCancellable>()
    private static var imageCache = ImageCache()
    func fetchRecipes() async throws -> [Recipe] {
        let urlString = baseURL
        guard let url = URL(string:urlString) else {throw APIError.invalidURL}
        
        let (data, response) = try await URLSession.shared.data(from:url)
        
        guard let r = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= r else {throw APIError.invalidResponse}
        do {
            let result = try JSONDecoder().decode(RecipeResponse.self, from: data)
            return result.recipes
        }catch{
            throw error
        }
    }
    func fetchRecipeImage(_ urlString : String?) async throws -> UIImage {
        if let cachedImage = RecipeService.imageCache.image(for: urlString) {
            return cachedImage
        }
        
        guard let url = URL(string:urlString ?? "") else {throw APIError.invalidURL}
        
        let (data, response) = try await URLSession.shared.data(from:url)
        
        guard let r = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= r else {throw APIError.invalidResponse}
        guard let image = UIImage(data: data) else {throw
            APIError.invalidData
        }
        RecipeService.imageCache.cacheImage(image: image, for: urlString)
        return image
    }
}

class ImageCache {
    var cache : [String : UIImage] = [:]
    func cacheImage(image : UIImage, for url : String?) {
        if let url = url {
            cache[url] = image
        }
    }
    func image(for url : String?) -> UIImage?{
        if let url {return cache[url]}
        else {return nil}
    }
}
