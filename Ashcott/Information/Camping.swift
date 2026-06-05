//
//  Camping.swift
//  Ashcott
//
//  Created by Nigel Gee on 16/05/2026.
//

import Foundation

nonisolated struct Camping: Codable {
    /// A property that is the header image for ``CampView``
    var image: String

    /// A property that is the first text of ``CampView``
    private var welcomeText: String

    /// A property that is the main text of ``CampView``
    private var bodyText: String
    
    /// A property that holds ``welcomeText`` of the drink item
    ///
    /// - Note: This converts text to display as markdown
    var displayWelcomeText: LocalizedStringResource { "\(welcomeText)" }

    /// A property that holds ``bodyText`` of the drink item
    ///
    /// - Note: This converts text to display as markdown
    var displayBodyText: LocalizedStringResource { "\(bodyText)"}
}
