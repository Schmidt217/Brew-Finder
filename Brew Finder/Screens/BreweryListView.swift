//
//  BreweryListView.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 9/21/22.
//

import SwiftUI

struct BreweryListView: View {
    @ObservedObject var networkManager = NetworkManager()
    
    let brewerySearch: String
    
    var body: some View {
        NavigationView {
            List(networkManager.breweries
            ) { brewery in
                    HStack {
                        Text(brewery.name)
                    }
            }
            .navigationTitle("Breweries")
        }//: NAVIGATION
        .onAppear {
            self.networkManager.fetchDataBySearch(name: brewerySearch)
        }
    }
}

//struct BreweryListView_Previews: PreviewProvider {
//    static var previews: some View {
//        BreweryListView()
//    }
//}
