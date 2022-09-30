//
//  BreweryListView.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 9/21/22.
//

import SwiftUI

struct BreweryListView: View {
//    @ObservedObject var networkManager = NetworkManager()
    
    let brewery: Brewery
    
    var body: some View {
        HStack{
            Image(systemName: "wineglass")
            Text(brewery.name)
        }
    }
}

//struct BreweryListView_Previews: PreviewProvider {
//    static let brew: Brewery = NetworkManager.fetchDataBySearch("4_noses")
//    static var previews: some View {
//        BreweryListView(brewery: brew)
//    }
//}
