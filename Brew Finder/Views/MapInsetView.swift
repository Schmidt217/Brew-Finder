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
    }
    
  
    
    var body: some View {
        let address = "\(brewery.street ?? "") \(brewery.city ?? ""), \(brewery.state ?? "") \(brewery.postal_code ?? "")"
        locationManager.locationString = address
        var annotations = [Marker(location: MapMarker(coordinate: annotation.coordinate))]
        annotation.title = brewery.name
       

        return Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: annotations) {_ in
            MapMarker(coordinate: annotation.coordinate)
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

