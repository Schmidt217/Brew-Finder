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
    
}
