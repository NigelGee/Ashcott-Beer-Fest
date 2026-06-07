//
//  Charity.swift
//  Ashcott
//
//  Created by Nigel Gee on 17/05/2026.
//

import Foundation

nonisolated struct CharityDetails: Codable {
    struct Charity: Codable, Identifiable {
        var title: String
        private var detail: String
        var url: URL?
        var image: String

        var id: UUID { UUID() }
        var displayDetail: LocalizedStringResource { "\(detail)" }
    }
    
    /// A property that shows the main title of ``SponsorView``
    var mainTitle: String

    /// A property that show a description of Charities
    private var description: String

    /// An array of charities
    var charities: [Charity]
    
    /// A property that holds ``description`` of the Charities
    ///
    /// - Note: This converts text to display as markdown
    var displayDescription: LocalizedStringResource { "\(description)" }
}
