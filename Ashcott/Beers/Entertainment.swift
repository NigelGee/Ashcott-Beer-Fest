//
//  Entertainment.swift
//  Ashcott
//
//  Created by Nigel Gee on 19/05/2026.
//

import Foundation

/// A struct that hold the elements of the Music bands and Entertainments
nonisolated struct Entertainment: Codable {
    struct Music: Codable, Identifiable {
        struct Band: Codable, Identifiable {
            var name: String
            var detail: String?
            var startTime: Date?
            var endTime: Date?

            var id: UUID { UUID() }

            var displayDetail: LocalizedStringResource { "\(detail ?? "")" }
        }

        var day: String
        var band: [Band]

        var id: UUID { UUID() }
    }

    private var description: String

    /// A property the will display the title and year of band list
    var bandTitle: String
    var music: [Music]
    var sponsor: String
    var sponsorTel: String?


    var displaySponsor: LocalizedStringResource { "\(sponsor)" }
    var displayDescription: LocalizedStringResource { "\(description)" }
}
