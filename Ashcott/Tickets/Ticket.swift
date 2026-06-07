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

        static let example = Price(
            type: "Friday Night - Adult",
            description: "Entrance from 7pm. 18 and over and allow to consume alcohol drinks. ID may required if you are lucky enough to look under 25.",
            amount: 12,
            url: URL(string: "https://ashcott-beer-festival.sumupstore.com/product/adult-friday-eve"),
            image: "farmerBully.png"
        )
    }
    
    var cutoffDate: Date
    private var description: String
    var prices: [Price]
    var closedText: String

    var descriptionDisplay: LocalizedStringResource { "\(description)" }

    static let loading = Ticket(cutoffDate: .now, description: "Loading", prices: [], closedText: "")

    static let example = Ticket(
        cutoffDate: .distantFuture,
        description: "All adult tickets include this year’s glass.\n\n[Camping must be booked in advance of the event here.](https://docs.google.com/forms/d/e/1FAIpQLSczKZgcVQyzllXyRiDzlN2Y7n29PqDDNf6sczvFDjHjnVLKVg/viewform)\n\n**Please note:** If you get a *‘On the Farm’* glass (this year’s glass) on Friday night and bring it back with you on Saturday you’ll get a beer token instead of another glass.",
        prices: [.example],
        closedText: "Advance Tickets are now closed! However you can still buy them at the entrance to beer fest site"
    )
}
