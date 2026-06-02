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
            var detail: String?
            var time: String?
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
    var bandTitle: String
    var music: [Music]
    var sponsor: String
    var sponsorTel: String?


    var displaySponsor: LocalizedStringResource { "\(sponsor)" }
    var displayDescription: LocalizedStringResource { "\(description)" }
}
