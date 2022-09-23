//
//  SearchView.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 9/17/22.
//

import SwiftUI

struct SearchView: View {
    @State private var brewSearch = ""
    @State private var isShowingResultsView = false
    @ObservedObject var networkManager = NetworkManager()

    let gradient = LinearGradient(colors: [Color.orange, Color.green],
                                  startPoint: .top, endPoint: .bottom)

    var body: some View {
        NavigationView {
            ZStack {
                gradient
                    .opacity(0.25)
                    .ignoresSafeArea()

                VStack {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 1)
                        .background(LinearGradient(colors: [.green.opacity(0.3), .orange.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    Text("Search For Breweries")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.bold)
                        .padding()

                    Spacer()

                    HStack {
                        TextField("Search by Name", text: $brewSearch)
                            .frame(width: 300, height: 50.0)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .border(.primary)
                            .cornerRadius(3.0)
                            .padding()
                            .onChange(of: brewSearch) { newValue in
                                            brewSearch = newValue.replacingOccurrences(of: " ", with: "_")
                                        }
                            .onSubmit {
                                
                        }
                        NavigationLink(destination: BreweryListView(brewerySearch: brewSearch), isActive: $isShowingResultsView) {
                            Button(action: {
                                isShowingResultsView = true
                            }) {
                                Image(systemName: "arrow.2.squarepath")
                            }
                        }
                            

                        

                    }

                    HStack {
                        ZStack {
                            Capsule()
                                .fill(Color("ColorBlue"))
                            Capsule()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            HStack {
                                Text("Search by your location")
                                Image(systemName: "location")
                                    .font(.system(size: 24, weight: .bold))
                            }
                        } //: Button ZStack
                        .foregroundColor(.white)
                        .frame(width: 300, height: 80)
                        .onTapGesture {
                            // code
                        }
                    } //: HStack

                    Spacer()
                        .frame(maxHeight: 400)
                } //: VStack
            } //: ZStack
            .navigationTitle("Brew Finder")
            .font(.title2)
        }//: NAVIGATION
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
