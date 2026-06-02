//
//  Sponsorship.swift
//  Ashcott
//
//  Created by Nigel Gee on 17/05/2026.
//

import Foundation

nonisolated struct Sponsorship: Codable {
    struct Sponsor: Codable, Identifiable, Comparable {
        var name: String
        var url: URL?

        var id: UUID { UUID() }

        static func <(lhs: Sponsor, rhs: Sponsor) -> Bool {
            lhs.name < rhs.name
        }
    }

    var mainTitle: String
    private var description: String
    var image: String
    var sponsors: [Sponsor]
    var yearTitle: String

    var displayDescription: LocalizedStringResource { "\(description)" }
}
