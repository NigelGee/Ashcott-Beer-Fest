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

        static let example = Charity(
            title: "Ashcott Primary School",
            detail: "Ashcott Primary school is a caring and welcoming school. It puts children at the heart of everything they do.  They have close links with our community and believe in working together to inspire children to be proud of their community and the area in which they live. The money raised is used solely for the benefit of the children currently attending the school",
            url: URL(string: "https://www.ashcott.somerset.sch.uk"),
            image: "school.jpg"
        )
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

    static let example = CharityDetails(
        mainTitle: "The Charities we support!",
        description: "The Ashcott Beer Fest is about the beer and having a great time.  But we do it for a serious reason - to raise money for the three main charitable concerns in the parish (see below). We also donate to others local charities too.",
        charities: [.example]
    )
}
