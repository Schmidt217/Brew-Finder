//
//  FavoritesView-ViewModel.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 12/26/22.
//

import Foundation


    class ViewModel: ObservableObject {
        @Published var breweries: [Brewery] = []
        
        let savedFavorites = FileManager.documentsDirectory.appendingPathComponent("FavoritedBreweries")
        
        init() {
            
            do {
                let data = try Data(contentsOf: savedFavorites)
                breweries = try JSONDecoder().decode([Brewery].self, from: data)
            } catch {
                breweries = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(breweries)
                try data.write(to: savedFavorites, options: [.atomicWrite, .completeFileProtection])
            }catch {
                print("Unable to save brewery!")
            }
        }
        
        func addBreweryToFavorites(brewery: Brewery) {
            let breweryToSave = Brewery(id: brewery.id, name: brewery.name, brewery_type: brewery.brewery_type, street: brewery.street, address_2: brewery.address_2, address_3: brewery.address_3, city: brewery.city, state: brewery.state, postal_code: brewery.postal_code, country: brewery.country, latitude: brewery.latitude, longitude: brewery.longitude, phone: brewery.phone, website_url: brewery.website_url)
            breweries.append(breweryToSave)
            save()
        }
        
        func removeBreweryFromFavorites(brewery: Brewery) {
            let breweryToRemove = Brewery(id: brewery.id, name: brewery.name, brewery_type: brewery.brewery_type, street: brewery.street, address_2: brewery.address_2, address_3: brewery.address_3, city: brewery.city, state: brewery.state, postal_code: brewery.postal_code, country: brewery.country, latitude: brewery.latitude, longitude: brewery.longitude, phone: brewery.phone, website_url: brewery.website_url)
            breweries.removeAll { brewery in
                return brewery == breweryToRemove
            }
            save()
        }
        
        func loadFavorites() {
            do {
                let data = try Data(contentsOf: savedFavorites)
                breweries = try JSONDecoder().decode([Brewery].self, from: data)
            } catch {
                breweries = []
            }
        }
    }

