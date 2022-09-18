//
//  ContentView.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 9/17/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
                SearchView()
                    .tabItem {
                        Label("Find Brews", systemImage: "wineglass")
                }
                FavoritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "star.square.fill")
                    }
                    
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
