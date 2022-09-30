//
//  BreweryDetailView.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 9/24/22.
//

import SwiftUI

struct BreweryDetailView: View {
    let brewery: Brewery
    
    var body: some View {
        NavigationStack {
            Text(brewery.name)
                .font(.system(.title))
                .padding(10)
                .multilineTextAlignment(.center)

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
            
            MapInsetView(brewery: brewery)
                .cornerRadius(10)
                .padding()
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
