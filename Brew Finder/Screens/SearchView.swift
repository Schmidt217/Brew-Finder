//
//  SearchView.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 9/17/22.
//

import SwiftUI
import CoreLocation


struct SearchView: View {
    
    //    @State private var path: [Brewery] = []
    
    @State private var brewSearch = ""
    @ObservedObject var networkManager = NetworkManager()
    @ObservedObject var locationManager = LocationManager()

    
    let gradient = LinearGradient(colors: [Color.orange, Color.green],
                                  startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        NavigationStack {
            ZStack {
                gradient
                    .opacity(0.25)
                    .ignoresSafeArea()
                
                List{
                    Text("Search For Breweries")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                    
                    TextField("Search by Name", text: $brewSearch)
                        .frame(width: 300, height: 50.0)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .border(.primary)
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
                            locationManager.requestAuthorization(always: true)
                            guard let latitude = CLLocationManager().location?.coordinate.latitude else {return}
                            guard let longitude = CLLocationManager().location?.coordinate.longitude else {return}
                            networkManager.fetchDataByLocation(latitude: latitude, longitude: longitude)
                            
                            }
                        } //: HStack
                        
                        ForEach(networkManager.breweries) { brewery in
                            NavigationLink(destination: BreweryDetailView(brewery: brewery)) {
                                BreweryListView(brewery: brewery)
                            }
                        }
                    }
                }
            .navigationTitle("Brew Finder")
            }
        }
    }



struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
