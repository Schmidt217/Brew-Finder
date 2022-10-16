//
//  LocationManager.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 9/24/22.
//

import Combine
import CoreLocation
import Foundation
import MapKit

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    lazy var geocoder = CLGeocoder()

    var locationString = ""
    @Published var invalid: Bool = false

    let networkManager = NetworkManager()
    
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    func getLatLngFromAddress(completionHandler: @escaping (CLLocationCoordinate2D) -> Void) {
    
        geocoder.geocodeAddressString(locationString) { (placemarks, error) in
            if let error = error {
                DispatchQueue.main.async {
                    self.invalid = true
                }
                print(error.localizedDescription)
            }

            guard let placemark = placemarks?.first else { return }
            
            guard let lat = placemark.location?.coordinate.latitude else { return }

            guard let lng = placemark.location?.coordinate.longitude else { return }

            let coords = CLLocationCoordinate2D(latitude: lat, longitude: lng)
//            print(coords)
            completionHandler(coords)
        }
    }

    func openMapWithAddress() {
        geocoder.geocodeAddressString(locationString) { placemarks, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.invalid = true
                }
                print(error.localizedDescription)
            }

            guard let placemark = placemarks?.first else {
                return
            }

            guard let lat = placemark.location?.coordinate.latitude else { return }

            guard let lon = placemark.location?.coordinate.longitude else { return }

            let coords = CLLocationCoordinate2DMake(lat, lon)

            let place = MKPlacemark(coordinate: coords)

            let mapItem = MKMapItem(placemark: place)
            mapItem.name = self.locationString
            mapItem.openInMaps(launchOptions: nil)
        }
    }

    public func requestAuthorization(always: Bool = false) {
        if always {
            locationManager.requestAlwaysAuthorization()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = status
    }
}
