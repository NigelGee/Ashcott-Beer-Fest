//
//  Ticket.swift
//  Ashcott
//
//  Created by Nigel Gee on 17/05/2026.
//

import Foundation


nonisolated struct Ticket: Codable {
    struct Price: Codable, Identifiable {
        var type: String
        private var description: String
        var amount: Double
        var url: URL?
        var image: String?

        var displayDescription: LocalizedStringResource { "\(description)" }
        var id: UUID { UUID() }
    }
    
    var cutoffDate: Date
    private var description: String
    var prices: [Price]
    var closedText: String

    var descriptionDisplay: LocalizedStringResource { "\(description)" }

    static let loading = Ticket(cutoffDate: .now, description: "Loading", prices: [], closedText: "")
}
