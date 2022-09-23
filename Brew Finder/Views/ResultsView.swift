//
//  ResultsView.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 9/21/22.
//

import SwiftUI

struct ResultsView: View {
    
    let url: String?
    
    var body: some View {
        WebView(urlString: url)
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(url: "https://www.google.com")
    }
}
