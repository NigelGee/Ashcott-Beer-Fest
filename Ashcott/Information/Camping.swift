//
//  Camping.swift
//  Ashcott
//
//  Created by Nigel Gee on 16/05/2026.
//

import Foundation

nonisolated struct Camping: Codable {
    var image: String
    private var welcomeText: String
    private var bodyText: String

    var welcomeTextDisplay: LocalizedStringResource { "\(welcomeText)" }
    var bodyTextDisplay: LocalizedStringResource { "\(bodyText)"}
}
