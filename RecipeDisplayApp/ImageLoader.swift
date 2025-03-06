//
//  ImageLoader.swift
//  RecipeDisplayApp
//
//  Created by apple on 3/4/25.
//

import Foundation
import SwiftUI

class ImageLoader : ObservableObject {
    
    @Published var image : UIImage?
    @ObservedObject var service = RecipeService()
    
    @MainActor func getRecipeImage(for url: String?){
        Task {
            do {
                image = try await service.fetchRecipeImage(url)
            } catch {
                print(error)
            }
        }
    }
}
