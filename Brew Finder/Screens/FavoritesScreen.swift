//
//  FavoritesView.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 9/17/22.
//

import SwiftUI

struct FavoritesScreen: View {
    @StateObject private var viewModel = ViewModel()
    
    let gradient = LinearGradient(colors: [Color("DarkGreen"), Color("Brown")],
                                  startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        NavigationStack {
            ZStack {
                gradient
                    .opacity(0.35)
                    .ignoresSafeArea()
                
                VStack {
                    if viewModel.breweries.isEmpty {
                        Text("Add favorite breweries to see them here!")
                    }
                    List {
                        ForEach(viewModel.breweries) { brewery in
                            NavigationLink(destination: BreweryDetailView(brewery: brewery)) {
                                BreweryListView(brewery: brewery)
                            }
                        }
                    }
                    .background(.clear)
                    .scrollContentBackground(.hidden)
                    .blendMode(viewModel.breweries.isEmpty ? .destinationOver : .normal)
                } //: VSTACK
                .padding()
                .navigationTitle("Favorite Brews")
                .navigationBarTitleDisplayMode(.large)
                .foregroundColor(Color("DarkGreen"))
                .onAppear {
                    viewModel.loadFavorites()
                }
            }
           
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesScreen()
    }
}
