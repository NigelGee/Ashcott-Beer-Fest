//
//  String-Helper.swift
//  Ashcott
//
//  Created by Nigel Gee on 19/05/2026.
//

import Foundation

extension String {

    /// A computed property that removes a space for telephone number
    var formatted: String {
        self.replacingOccurrences(of: " ", with: "")
    }
}
