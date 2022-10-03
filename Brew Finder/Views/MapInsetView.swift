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
    @State var annotation: MKPointAnnotation
    
    var brewery: Brewery
    
    struct Place: Identifiable {
        let id = UUID()
        let name: String
        let coordinate: CLLocationCoordinate2D
    }
    var annotations = [
        Place(name: "xyz", coordinate: CLLocationCoordinate2D(latitude: 34.011286, longitude: -116.166868))
    ]
    
    var body: some View {

        return Map(coordinateRegion: $region, annotationItems: annotations) {_ in
            MapMarker(coordinate: annotation.coordinate)
        }
            .frame(width: 300, height: 300)
    }
}

//struct MapInsetView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        MapInsetView(brewery: brewery)
//    }
//}
