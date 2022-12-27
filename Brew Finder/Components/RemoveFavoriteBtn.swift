//
//  RemoveFavoriteBtn.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 12/20/22.
//

import SwiftUI

struct RemoveFavoriteBtn: View {
    @StateObject private var viewModel = ViewModel()
    
    let brewery: Brewery
    
    var body: some View {
        Button {
            viewModel.removeBreweryFromFavorites(brewery: brewery)
        
        } label: {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 20, height: 20)
        }
    }
}

struct RemoveFavoriteBtn_Previews: PreviewProvider {
    static var previews: some View {
        RemoveFavoriteBtn(brewery: Brewery.example)
    }
}
