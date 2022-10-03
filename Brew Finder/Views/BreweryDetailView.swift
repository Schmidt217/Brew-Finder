//
//  BreweryDetailView.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 9/24/22.
//

import SwiftUI
import MapKit

struct BreweryDetailView: View {
    
    let brewery: Brewery
    
    func getLat() -> CLLocationDegrees {
        guard let latitude = brewery.latitude else {return 34.011286}
        return CLLocationDegrees(latitude)!
    }
    func getLng() -> CLLocationDegrees {
        guard let longitude = brewery.longitude else {return -116.166868}
        return CLLocationDegrees(longitude)!
    }
    
    
    var body: some View {
        let coordinate = CLLocationCoordinate2D(
            latitude: getLat(), longitude: getLng())
        
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = brewery.name
        
       return NavigationStack {
            Text(brewery.name)
                .font(.system(.title))
                .padding(10)
                .multilineTextAlignment(.center)
           Spacer()
            if brewery.website_url != nil {
                Link(destination: URL(string: brewery.website_url!)!) {
                    HStack{
                        Image(systemName: "link.circle.fill")
                        Text("Website")
                    }
                }
            }
            if brewery.phone != nil {
                Link(destination: URL(string: "tel:\(brewery.phone!)")!){
                    Image(systemName: "phone")
                    Text(brewery.phone!.applyPatternOnNumbers(pattern: "(###) ###-#### ", replacementCharacter: "#"))
                }
            }
           if (brewery.latitude != nil) && (brewery.longitude != nil) {
               MapInsetView(region: region, annotation: annotation, brewery: brewery)
                    .cornerRadius(10)
                    .padding()
           }
         
        }
        .navigationBarTitleDisplayMode(.inline)
  
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
