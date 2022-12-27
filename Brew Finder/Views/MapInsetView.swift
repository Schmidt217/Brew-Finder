//
//  MapInsetView.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 9/25/22.
//

import SwiftUI
import MapKit


struct MapInsetView: View {
    @State var region: MKCoordinateRegion
    @State var annotation = MKPointAnnotation()
    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    @ObservedObject var locationManager = LocationManager()
    
    var brewery: Brewery
    
    struct Marker: Identifiable {
        let id = UUID()
        var location: MapMarker
        var name: String
    }
    
  
    var body: some View {
        let address = "\(brewery.street ?? "") \(brewery.city ?? ""), \(brewery.state ?? "") \(brewery.postal_code ?? "")"
        locationManager.locationString = address
        let annotations = [Marker(location: MapMarker(coordinate: annotation.coordinate), name: brewery.name)]
        annotation.title = brewery.name
       
        return Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: annotations) {_ in
            MapAnnotation(coordinate: annotation.coordinate) {
                VStack {
                    ZStack {
                        Circle()
                            .frame(width: 45)
                            .foregroundColor(Color("Green"))
                        Circle()
                            .frame(width: 35)
                            .foregroundColor(Color("LightBrown"))
                        Image("beer-glass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                        
                    }
                   
                    Text(brewery.name)
                        .foregroundColor(Color("DarkGreen"))
                        .font(.title3)
                        .fontWeight(.bold)
                }
            }
        }
            .frame(width: 300, height: 300)
            .onAppear {
                locationManager.getLatLngFromAddress { coordinates in
                    region = MKCoordinateRegion(center: coordinates, span: span)
                    annotation.coordinate = coordinates
                   
                }
            }
          
    }
}

struct MapInsetView_Previews: PreviewProvider {
    static var previews: some View {
        MapInsetView(region: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 39.920540, longitude: -105.086647), span: MKCoordinateSpan(latitudeDelta: 6, longitudeDelta: 6)), brewery: Brewery.example)
    }
}

