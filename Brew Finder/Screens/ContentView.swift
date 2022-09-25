//
//  ContentView.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 9/17/22.
//

import SwiftUI

struct ContentView: View {
    let gradient = LinearGradient(colors: [Color.orange, Color.green],
                                  startPoint: .top, endPoint: .bottom)

    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Search")
                }
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "star")
                    Text("Favorites")
                }
    
        } //: Tab
        
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.backgroundColor = .gray
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
