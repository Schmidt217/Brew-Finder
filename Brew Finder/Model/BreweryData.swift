//
//  BreweryData.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 9/21/22.
//

import Foundation

struct Brewery: Decodable, Identifiable, Hashable {

    let id: String
    let name: String
    let brewery_type: String?
    let street: String?
    let address_2: String?
    let address_3: String?
    let city: String?
    let state: String?
    let postal_code: String?
    let country: String?
    let latitude: String?
    let longitude: String?
    let phone: String?
    let website_url: String?
    
    #if DEBUG
    static let example = Brewery(id: "001", name: "4 Noses", brewery_type: "micro", street: "8855 W. 116th Circle", address_2: "Unit 2c", address_3: "Extra address", city: "Broomfield", state: "CO", postal_code: "80021", country: "USA", latitude: "39.920540", longitude: "-105.086647", phone: "7204602797", website_url: "www.4nosesbrewing.com")
    #endif
    
}
