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

            /// A property that will show the title of band/entrainment
            var name: String

            /// A property that will show details of band/entrainment if provide
            var detail: String?

            /// A property that will show start time of band/entrainment if provide
            ///
            /// - Note: The raw data format "dd/MM/yyyy HH:mm"
            var startTime: Date?

            /// A property that will show end time of band/entrainment if provide
            ///
            /// - Note: The raw data format "dd/MM/yyyy HH:mm
            var endTime: Date?

            var id: UUID { UUID() }
            
            /// A property that holds ``detail`` of the drink item
            ///
            /// - Note: This converts text to display as markdown
            var displayDetail: LocalizedStringResource { "\(detail ?? "")" }
        }

        /// A property that will show the the day period
        var day: String

        /// A property that will hold the elements of the bands
        var bands: [Band]

        var id: UUID { UUID() }
    }

    /// A property that will display information about music and entrainment
    private var description: String

    /// A property that will display the title and year of band list
    var bandTitle: String
    var music: [Music]

    /// A property that will hold the sponsor name.
    var sponsor: String

    /// A property that will hold the sponsor telephone number if provided
    var sponsorTel: String?
    
    /// A property that holds ``sponsor`` of the drink item
    ///
    /// - Note: This converts text to display as markdown
    var displaySponsor: LocalizedStringResource { "\(sponsor)" }

    /// A property that holds ``description`` of the drink item
    ///
    /// - Note: This converts text to display as markdown
    var displayDescription: LocalizedStringResource { "\(description)" }
}
