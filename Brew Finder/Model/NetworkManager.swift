//
//  NetworkManager.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 9/21/22.
//

import Foundation

class NetworkManager: ObservableObject {
    @Published var breweries = [Brewery]()
    
    func fetchDataBySearch(name: String) {
        if let url = URL(string: "https://api.openbrewerydb.org/breweries?by_name=\(name)") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode([Brewery].self, from: safeData)
                            DispatchQueue.main.async {
                                self.breweries = results
                            }
                            
                        }catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
