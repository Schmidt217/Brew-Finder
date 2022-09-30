//
//  MapInsetView.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 9/25/22.
//

import SwiftUI
import MapKit

struct MapInsetView: View {
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 47.8283, longitude: -98.5795), span: MKCoordinateSpan(latitudeDelta: 90.0, longitudeDelta: 90.0))
    
    var brewery: Brewery
    
    var body: some View {

        Map(coordinateRegion: $region)
            .frame(width: 300, height: 300)
            .onAppear {
                if let latitude = brewery.latitude, let longitude = brewery.longitude {
                    region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude)!, longitude: CLLocationDegrees(longitude)!), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
                }
                
            }
    }
}

//struct MapInsetView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        MapInsetView(brewery: brewery)
//    }
//}
