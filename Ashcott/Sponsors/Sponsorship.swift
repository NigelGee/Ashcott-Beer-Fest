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

        static let example = Sponsor(name: "Amica Smart Homes", url: URL(string: "https://www.amicasmarthomes.com"))
    }

    var mainTitle: String
    private var description: String
    var image: String
    var sponsors: [Sponsor]
    var yearTitle: String

    var displayDescription: LocalizedStringResource { "\(description)" }

    static let example = Sponsorship(
        mainTitle: "Sponsorship",
        description: "Many local firms support us by sponsoring a barrel of beer.  Without this sponsorship, we would be unlikely to make any money for all our charities.  Some of our sponsors have been generous enough to keep supporting us for many years, and some only started recently. If you are interested in sponsoring a barrel please return the [Sponsorship form](https://www.ashcottbeerfest.org/Sponsors%20Form.pdf) by email to ashcottbeerfestsponsers@gmail.com.\n\nSponsorships are coming in thick and fast… but always room for more!  Thank you to those that have already sponsored us so far.\n\nNow that we pay for the marquee, more duty on the beer,  more VAT on the duty on the beer, our sponsors are even more valuable to us! And we recognise that these are hard times so…\n\n**Thank you from us!**",
        image: "committee.jpg",
        sponsors: [.example],
        yearTitle: "Our 2025 Heroes"
    )
}
