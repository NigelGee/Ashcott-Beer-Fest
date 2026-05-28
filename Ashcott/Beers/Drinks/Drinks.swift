//
//  Drink.swift
//  Ashcott
//
//  Created by Nigel Gee on 20/05/2026.
//

import Foundation

nonisolated struct Drinks: Codable {
    struct Category: Codable, Identifiable {
        struct Item: Codable, Identifiable, Comparable {
            var id: String
            var name: String
            var award: String?
            var abv: Double?
            var detail: String
            var brewer: String?
            var sponsor: String?
            var sponsorTel: String?
            var canRate: Bool

            var displayName: LocalizedStringResource { "\(name)" }
            var displayDetail: LocalizedStringResource { "\(detail)" }
            var displayBrewer: LocalizedStringResource { "\(brewer ?? "")" }
            var displaySponsor: LocalizedStringResource { "\(sponsor ?? "")" }

            static func <(lhs: Item, rhs: Item) -> Bool {
                lhs.id < rhs.id
            }

            static let example = Item(
                id: "2501",
                name: "Badgworth IPA",
                award: "1st",
                abv: 4.4,
                detail: "Premium Pale Ale.",
                brewer: "[Badgworth Brewhouse, Somerset](https://badgworthbrewhouse.com)",
                sponsor: "[Holland & Odam](https://www.hollandandodam.co.uk)",
                sponsorTel: "01458 841411",
                canRate: true
            )
        }

        var title: String
        var items: [Item]

        var id: UUID { UUID() }
    }

    var title: String
    var description: String
    var categories: [Category]

}
