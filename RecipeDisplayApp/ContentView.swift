//
//  ContentView.swift
//  RecipeDisplayApp
//
//  Created by apple on 2/27/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = RecipeViewModel()
    var body: some View {
            VStack {
                Button(action: viewModel.getRecipes) {
                    Text("Refresh")
                        .foregroundColor(.accentColor)
                }
                Text("Recipes")
                switch viewModel.currentState {
                case .loaded:
                    if (viewModel.recipeList != []) {
                        ScrollView {
                            ForEach(viewModel.recipeList) {recipe in
                                RecipeCell(recipe: recipe, viewModel: viewModel)
                            }
                        }
                    } else {
                        Text("No recipes available")
                    }
                case .error:
                    Text("An error occured, try again later")
                case .loading:
                    ProgressView()
                }
            }
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
