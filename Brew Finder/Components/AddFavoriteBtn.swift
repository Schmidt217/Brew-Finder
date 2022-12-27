//
//  AddFavoriteBtn.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 11/12/22.
//

import SwiftUI

struct AddFavoriteBtn: View {
    @StateObject private var viewModel = ViewModel()
    let brewery: Brewery
    
    var body: some View {
        Button {
            viewModel.addBreweryToFavorites(brewery: brewery)
        
        } label: {
            Image(systemName: "star")
                .resizable()
                .frame(width: 20, height: 20)
        }
        
            
    }
}

struct AddFavoriteBtn_Previews: PreviewProvider {
    static var previews: some View {
        AddFavoriteBtn(brewery: Brewery.example)
    }
}
