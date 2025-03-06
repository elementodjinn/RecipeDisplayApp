//
//  RecipeViewModel.swift
//  RecipeDisplayApp
//
//  Created by apple on 2/27/25.
//

import Foundation
import SwiftUI

enum DisplayState {
    case loading
    case loaded
    case error
}

class RecipeViewModel : ObservableObject {
    @Published var recipeList : [Recipe] = []
    @Published var currentState = DisplayState.loaded
    @Published var recipeService : RecipeServiceProtocol
    init(_ service : RecipeServiceProtocol = RecipeService()){
        recipeService = service
        Task{
            await getRecipes()
        }
    }
    @MainActor func getRecipes(){
        Task {
            do {
                currentState = .loading
                recipeList = try await recipeService.fetchRecipes()
                currentState = .loaded
            } catch {
                currentState = .error
                print(error)
            }
        }
    }
}
