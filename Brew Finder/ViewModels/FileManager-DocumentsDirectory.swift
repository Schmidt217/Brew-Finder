//
//  FileManager-DocumentsDirectory.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 12/26/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
