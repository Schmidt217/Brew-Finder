//
//  SearchView.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 9/17/22.
//

import SwiftUI
import CoreLocation


struct SearchScreen: View {
    
    @State private var brewSearch = ""
    @ObservedObject var networkManager = NetworkManager()
    @ObservedObject var locationManager = LocationManager()
    
    let gradient = LinearGradient(colors: [Color("DarkGreen"), Color("Brown")], startPoint: .topLeading, endPoint: .bottomTrailing)
    
    var body: some View {
        NavigationStack {
            ZStack {
                gradient
                    .ignoresSafeArea()
                
                VStack {
                    Text("Search For Breweries")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    TextField("", text: $brewSearch)
                        .padding(.all)
                        .frame(width: 300, height: 50.0)
                        .textInputAutocapitalization(.never)
                        .foregroundColor(.white)
                        .background(
                               ZStack{
                                   if brewSearch.count == 0 {
                                       HStack {
                                           Text("Search by Name")
                                               .foregroundColor(.gray)
                                               .padding(.all)
                                           Spacer()
                                     }
                                    .frame(maxWidth: .infinity)
                                   }
                               }
                           )
                        .disableAutocorrection(true)
                        .border(Color.white)
                        .cornerRadius(3.0)
                        .padding()
                        .onChange(of: brewSearch) { newValue in
                            brewSearch = newValue
                            Task.init(operation: {
                                if !newValue.isEmpty {
                                    self.networkManager.fetchDataBySearch(name: newValue.replacingOccurrences(of: " ", with: "_"))
                                }
                            })
                        }
                    
                    HStack(alignment: .center) {
                        ZStack {
                            Capsule()
                                .fill(Color("Yellow"))
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
                            locationManager.requestAuthorization(always: true)
                            guard let latitude = CLLocationManager().location?.coordinate.latitude else { return }
                            guard let longitude = CLLocationManager().location?.coordinate.longitude else { return }
                            networkManager.fetchDataByLocation(latitude: latitude, longitude: longitude)
                            
                            }
                        } //: HStack
                                List {
                                    ForEach(networkManager.breweries) { brewery in
                                        NavigationLink(destination: BreweryDetailView(brewery: brewery)) {
                                            BreweryListView(brewery: brewery)
                                        }
                                }
                            }
                                .background(.clear)
                                .scrollContentBackground(.hidden)
                                .blendMode(networkManager.breweries.isEmpty ? .destinationOver : .normal)
                        
                    }
                }
            .navigationTitle("Brew Finder")
            .navigationBarColor(backgroundColor: .clear, titleColor: UIColor(Color("Yellow")))
            .foregroundColor(Color("DarkGreen"))
            }
        }
    }



struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen()
    }
}
