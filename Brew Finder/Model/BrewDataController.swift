//
//  BrewDataController.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 11/12/22.
//

import CoreData
import Foundation

class BrewDataController: ObservableObject {
    let container = NSPersistentContainer(name: "BreweryDataModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
   
}
