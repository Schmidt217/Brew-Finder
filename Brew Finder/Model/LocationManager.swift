//
//  LocationManager.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 9/24/22.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    let networkManager = NetworkManager()
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined

    override init() {
        super.init()
        self.locationManager.delegate = self
    }
    

    public func requestAuthorization(always: Bool = false) {
        if always {
            self.locationManager.requestAlwaysAuthorization()
        } else {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationStatus = status
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
//        if let location = locations.last {
//            locationManager.stopUpdatingLocation()
//            let lat = location.coordinate.latitude
//            let lng = location.coordinate.longitude
//            networkManager.fetchDataByLocation(latitude: lat, longitude: lng)
//            print(lat)
//            print(lng)
//        }
//    }
}
