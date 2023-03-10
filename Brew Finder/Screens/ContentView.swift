//
//  ContentView.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 9/17/22.
//

import SwiftUI

struct ContentView: View {
//    init() {
//        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: Color(red: 1.0, green: 1.0, blue: 1.0)]
//
//    }
    
    let gradient = LinearGradient(colors: [Color("DarkGreen"), Color("Brown")], startPoint: .top, endPoint: .bottom)

    var body: some View {
            TabView {
                SearchScreen()
                    .tabItem {
                        Label("Search", systemImage: "square.grid.2x2")
                    }
                
                FavoritesScreen()
                    .tabItem {
                        Label("Favorites", systemImage: "star")
                    }
        
            } //: Tab
            .accentColor(Color("Yellow"))
            .onAppear {
                let tabBarAppearance = UITabBarAppearance()
                tabBarAppearance.backgroundColor = UIColor(.white)
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
