//
//  Entertainment.swift
//  Ashcott
//
//  Created by Nigel Gee on 19/05/2026.
//

import Foundation

nonisolated struct Entertainment: Codable {
    struct Music: Codable, Identifiable {
        struct Band: Codable, Identifiable {
            var name: String
            var details: String?
            var time: String?
            var startTime: Date?
            var endTime: Date?

            var id: UUID { UUID() }

            var detailsDisplay: LocalizedStringResource { "\(details ?? "")" }
        }

        var day: String
        var band: [Band]

        var id: UUID { UUID() }
    }

    private var description: String
    var bandTitle: String
    var music: [Music]
    var sponsor: String
    var sponsorTel: String?


    var sponsorDisplay: LocalizedStringResource { "\(sponsor)" }
    var descriptionDisplay: LocalizedStringResource { "\(description)" }
}
