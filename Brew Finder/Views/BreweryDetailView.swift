//
//  BreweryDetailView.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 9/24/22.
//

import SwiftUI
import MapKit
import CoreLocation


struct BreweryDetailView: View {
    @ObservedObject var locationManager = LocationManager()
    @StateObject private var viewModel = ViewModel()
    @State var isFavorite: Bool = false

    let brewery: Brewery

    let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
    
    func getLat() -> CLLocationDegrees {
        guard let latitude = brewery.latitude else {return 0.00}
        return CLLocationDegrees(latitude)!
    }
    func getLng() -> CLLocationDegrees {
        guard let longitude = brewery.longitude else {return 0.00}
        return CLLocationDegrees(longitude)!
    }
    func getStreet() -> String {
        guard let street = brewery.street else {return ""}
        return street
    }
    func getCity() -> String {
        guard let city = brewery.city else {return ""}
        return city
    }
    func getState() -> String {
        guard let state = brewery.state else {return ""}
        return state
    }
    func getPostalCode() -> String {
        guard let postalCode = brewery.postal_code else {return ""}
        return postalCode
    }
    
    func breweryType() -> String {
        switch brewery.brewery_type {
        case "planning":
            return "In Planning"
        case "taproom":
            return "Taproom"
        case "micro":
            return "Micro Brewery"
        case "brewpub":
            return "Brewpub"
        case "regional":
            return "Regional Brewery"
        case "large":
            return "National Brewery"
        default:
            return "Unknown Type of Brewery"
        }
    
    }
    
    let gradient = LinearGradient(colors: [Color("DarkGreen"), Color("Brown")],
                                  startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        let coords = CLLocationCoordinate2D(latitude: getLat(), longitude: getLng())
        let region = MKCoordinateRegion(center: coords, span: span)
        
        let address = "\(getStreet()) \(getCity()), \(getState()) \(getPostalCode())"
        locationManager.locationString = address
    
       return NavigationStack {
           ZStack {
               gradient
                   .opacity(0.35)
                   .ignoresSafeArea()
               VStack {
                   Text(brewery.name)
                       .font(.system(.title))
                       .padding(30)
                       .multilineTextAlignment(.center)
                   Text("Brewery Type: \(breweryType())")
                   Spacer()
                   if  let url = brewery.website_url {
                       Link(destination: URL(string: url)!) {
                           HStack{
                               Image(systemName: "link.circle.fill")
                               Text("Website")
                                   .font(.title2)
                           }
                       }
                   }
                   if let phoneNumber = brewery.phone {
                       Link(destination: URL(string: "tel:\(phoneNumber)")!){
                           Image(systemName: "phone")
                           Text(phoneNumber.applyPatternOnNumbers(pattern: "(###) ###-#### ", replacementCharacter: "#"))
                               .font(.title3)
                       }
                       .padding()
                   }
                   Spacer()
                   Group {
                       Text(getStreet())
                       if brewery.address_2 != nil {
                           Text(brewery.address_2!)
                       }
                       if brewery.address_3 != nil {
                           Text(brewery.address_3!)
                       }
                       Text("\(getCity()), \(getState())")
                       Text(getPostalCode())
                    }
                       .onTapGesture {
                           locationManager.openMapWithAddress()
                       }
                   .alert(isPresented: $locationManager.invalid) {
                       Alert(title: Text("Something went Wrong"), message: Text("It looks like we don't have a valid address for this brewery"), dismissButton: .default(Text("OK"), action:{
                           locationManager.invalid = false
                       }))
                   }
                   Spacer()
                   
                   
                   MapInsetView(region: region, brewery: brewery)
                       .cornerRadius(10)
                       .padding()
                     
               }//: VStack
           }//: ZStack
        }//: Navigation Stack
       .onAppear {
           let favorites = viewModel.breweries
           if favorites.contains(brewery) {
               isFavorite = true
           } else {
               isFavorite = false
           }
       }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if isFavorite {
                    RemoveFavoriteBtn(brewery: brewery)
                } else {
                    AddFavoriteBtn(brewery: brewery)
                }
 
            }

        }
    }
}

extension String {
    func applyPatternOnNumbers(pattern: String, replacementCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

//struct BreweryDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        BreweryDetailView(brewery: Brewery.example)
//    }
//}
