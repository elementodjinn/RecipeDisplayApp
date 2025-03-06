//
//  CachedImage.swift
//  RecipeDisplayApp
//
//  Created by apple on 3/4/25.
//

import SwiftUI

struct CachedImage: View {
    let url: String?
    var imageLoader = ImageLoader()
    var body: some View {
        VStack{
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
            } else {
                ProgressView()
            }
        }.task {
            imageLoader.getRecipeImage(for: url)
        }
    }
    
}

/*struct CachedImage_Previews: PreviewProvider {
    static var previews: some View {
        CachedImage()
    }
}*/
