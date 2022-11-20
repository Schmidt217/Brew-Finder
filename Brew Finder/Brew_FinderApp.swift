//
//  Brew_FinderApp.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 9/17/22.
//

import SwiftUI

@main
struct Brew_FinderApp: App {
    // Keeps data controller alive the entire time the app is running
    @StateObject private var dataController = BrewDataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}

