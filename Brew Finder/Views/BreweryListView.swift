//
//  BreweryListView.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 9/21/22.
//

import SwiftUI

struct BreweryListView: View {
    
    let brewery: Brewery
    
    var body: some View {
        HStack{
            Image("beer-glass")
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35)
            Text(brewery.name)
            Spacer()
        }
    }
}

struct BreweryListView_Previews: PreviewProvider {
    static var previews: some View {
        BreweryListView(brewery: Brewery.example)
    }
}

