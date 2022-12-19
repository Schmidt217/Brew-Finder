//
//  FavoritesView.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 9/17/22.
//

import SwiftUI

struct FavoritesScreen: View {
    @FetchRequest(sortDescriptors: []) var brews: FetchedResults<Brew>

    var body: some View {
        NavigationStack {
            VStack {
                if let breweries = brews {
                    List(breweries) { brew in
                        let _ = print(brew)
                        Text(brew.name ?? "Unknown")
                    }//: BrewLIST
                }
            } //: VSTACK
            .navigationTitle("Favorite Brews")
            .navigationBarTitleDisplayMode(.large)
            .foregroundColor(Color("DarkGreen"))
        }//: NAVIGATION STACK
      

    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesScreen()
    }
}
