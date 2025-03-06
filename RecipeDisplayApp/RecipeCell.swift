//
//  RecipeCell.swift
//  RecipeDisplayApp
//
//  Created by apple on 3/1/25.
//

import SwiftUI

struct RecipeCell: View {
    let recipe : Recipe
    @ObservedObject var viewModel : RecipeViewModel
    var body: some View {
        HStack{
            CachedImage(url: recipe.photo_url_small)
            Spacer()
            VStack{
                Text(recipe.cuisine.capitalized)
                    .italic()
                    .font(.system(size: 15))
                Text(recipe.name.capitalized)
                    .font(.system(size: 25))
            }
        }
        .padding()
    }
}

/*struct RecipeCell_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCell()
    }
}*/
