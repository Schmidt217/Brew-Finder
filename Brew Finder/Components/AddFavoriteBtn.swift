//
//  AddFavoriteBtn.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 11/12/22.
//

import SwiftUI

struct AddFavoriteBtn: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    let brewery: Brewery
    
    var body: some View {
        Button {
            
            let brew = Brew(context: managedObjectContext)
            
            brew.id = brewery.id
            brew.name = brewery.name
            brew.brewery_type = brewery.brewery_type
            brew.street = brewery.street
            brew.address_2 = brewery.address_2
            brew.address_3 = brewery.address_3
            brew.city = brewery.city
            brew.state = brewery.state
            brew.postal_code = brewery.postal_code
            brew.country = brewery.country
            brew.latitude = brewery.latitude
            brew.longitude = brewery.longitude
            brew.phone = brewery.phone
            brew.website_url = brewery.website_url
            
        
            try? managedObjectContext.save()
            print("favorite pressed! \(brewery.name)")
            print(brewery)
        } label: {
            Image(systemName: "star")
                .resizable()
                .frame(width: 20, height: 20)
        }
        
            
    }
}

//struct AddFavoriteBtn_Previews: PreviewProvider {
//    static var previews: some View {
//        AddFavoriteBtn()
//    }
//}
