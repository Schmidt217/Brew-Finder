//
//  Toast.swift
//  Brew Finder
//
//  Created by Michael Schmidt on 12/27/22.
//

import Foundation

struct Toast: Equatable {
    var type: ToastStyle
    var title: String
    var message: String
    var duration: Double = 3
}
