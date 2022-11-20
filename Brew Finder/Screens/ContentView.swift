//
//  ContentView.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 9/17/22.
//

import SwiftUI

struct ContentView: View {
    
    let gradient = LinearGradient(colors: [Color("DarkGreen"), Color("Brown")],
                                  startPoint: .top, endPoint: .bottom)

    var body: some View {
            TabView {
                SearchScreen()
                    .tabItem {
                        Image(systemName: "square.grid.2x2")
                        Text("Search")
                    }
                
                FavoritesScreen()
                    .tabItem {
                        Image(systemName: "star")
                        Text("Favorites")
                    }
        
            } //: Tab
            .accentColor(Color("Green"))
            .onAppear {
                let tabBarAppearance = UITabBarAppearance()
                tabBarAppearance.backgroundColor = UIColor(Color("LightBrown"))
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
