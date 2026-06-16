//
//  Ticket.swift
//  Ashcott
//
//  Created by Nigel Gee on 17/05/2026.
//

import Foundation


nonisolated struct Ticket: Codable {
    struct Price: Codable, Identifiable, Comparable {

        /// A property the shows the type title for a ticket price
        var type: String

        /// A property that shows a description of the ticket price
        private var description: String

        /// A property that shows the cost of the ticket
        var amount: Double

        /// A property that shows the link to the "Sum Up" to able to buy the ticket, if provided
        var url: URL?

        /// A property that a image for ticket price, if provided
        var image: String?
        
        /// A property that holds ``description`` of the drink item
        ///
        /// - Note: This converts text to display as markdown
        var displayDescription: LocalizedStringResource { "\(description)" }
        
        var id: UUID { UUID() }

        static let example = Price(
            type: "Friday Night - Adult",
            description: "Entrance from 7pm. 18 and over and allow to consume alcohol drinks. ID may required if you are lucky enough to look under 25.",
            amount: 12,
            url: URL(string: "https://ashcott-beer-festival.sumupstore.com/product/adult-friday-eve"),
            image: "farmerBully.png"
        )

        static let example2 = Price(
            type: "Camping",
            description: "[Camping must be registered in advance of the event here.](https://docs.google.com/forms/d/e/1FAIpQLSczKZgcVQyzllXyRiDzlN2Y7n29PqDDNf6sczvFDjHjnVLKVg/viewform)",
            amount: 0,
            url: URL(string: "https://ashcott-beer-festival.sumupstore.com/product/camping-ticket"),
            image: "camping.png"
        )

        static func <(lhs: Price, rhs: Price) -> Bool {
            lhs.type < rhs.type
        }
    }
    
    /// A property for the cut off date to able buy advance tickets
    ///
    /// - Note: The raw data format is "dd/MM/yyyy HH;mm"
    var cutoffDate: Date

    /// A property that shows a header about tickets
    private var description: String

    /// An array of elements of ticket price
    var prices: [Price]

    /// A property that will show the text when advance ticket are no long available
    var closedText: String
    
    /// A property that holds ``description`` of the drink item
    ///
    /// - Note: This converts text to display as markdown
    var descriptionDisplay: LocalizedStringResource { "\(description)" }

    static let example = Ticket(
        cutoffDate: .distantFuture,
        description: "All adult tickets include this year’s glass.\n\n[Camping must be booked in advance of the event here.](https://docs.google.com/forms/d/e/1FAIpQLSczKZgcVQyzllXyRiDzlN2Y7n29PqDDNf6sczvFDjHjnVLKVg/viewform)\n\n**Please note:** If you get a *‘On the Farm’* glass (this year’s glass) on Friday night and bring it back with you on Saturday you’ll get a beer token instead of another glass.",
        prices: [.example],
        closedText: "Advance Tickets are now closed! However you can still buy them at the entrance to beer fest site"
    )
}
