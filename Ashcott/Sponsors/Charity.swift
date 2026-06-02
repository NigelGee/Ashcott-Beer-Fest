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

    var mainTitle: String
    private var description: String
    var charities: [Charity]

    var displayDescription: LocalizedStringResource { "\(description)" }
}
