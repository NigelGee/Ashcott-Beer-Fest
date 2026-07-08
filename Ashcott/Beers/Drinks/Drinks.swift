//
//  Drink.swift
//  Ashcott
//
//  Created by Nigel Gee on 20/05/2026.
//

import Foundation

/// A struct that hold the elements of Drink's category and item
nonisolated struct Drinks: Codable {
    struct Category: Codable, Identifiable {
        struct Item: Codable, Identifiable, Comparable {

            /// A property that holds a id of drink item
            ///
            /// This is a two digit year and the barrel number eg (2501)
            var id: String

            /// A property that holds the name of band
            var name: String

            /// A property that holds a award badge for drink item
            ///
            /// - Important: Must use 1st, 2nd or 3rd, Any other may not show.
            var award: String?

            /// A property that holds the ABV of the drink item
            var abv: Double?

            /// A property that holds details of the drink item
            var detail: String

            /// A property that holds the brewer name
            var brewer: String?

            /// A property that holds the sponsor name
            var sponsor: String?

            /// A property that holds the sponsor telephone number
            var sponsorTel: String?
            
            /// A property that holds the url to drink's Untappd page
            var untappd: String?

            var onSale: Bool

            /// A property that if `true` will show a rating button or view
            var canRate: Bool

            /// A property that holds ``detail`` of the drink item
            ///
            /// - Note: This converts text to display as markdown
            var displayDetail: LocalizedStringResource { "\(detail)" }

            /// A property that holds ``brewer`` of the drink item
            ///
            /// - Note: This converts text to display as markdown
            var displayBrewer: LocalizedStringResource { "\(brewer ?? "")" }

            /// A property that holds ``sponsor`` of the drink item
            ///
            /// - Note: This converts text to display as markdown
            var displaySponsor: LocalizedStringResource { "\(sponsor ?? "")" }

            static func <(lhs: Item, rhs: Item) -> Bool {
                lhs.id < rhs.id
            }

            static let example = Item(
                id: "2501",
                name: "Badgworth IPA",
                award: "1st",
                abv: 4.0,
                detail: "Premium Pale Ale.",
                brewer: "[Badgworth Brewhouse, Somerset](https://badgworthbrewhouse.com)",
                sponsor: "[Holland & Odam](https://www.hollandandodam.co.uk)",
                sponsorTel: "01458 841411",
                untappd: "https://untappd.com/b/badgworth-brewhouse-badgworth-ipa/5416133",
                onSale: true,
                canRate: true
            )
        }
        
        /// A property that holds main category title
        var title: String

        /// A property that holds drink items 
        var items: [Item]

        var id: UUID { UUID() }
    }
    
    /// A property that holds the main drink title
    var title: String

    /// A property that holds information regarding the drinks
    var description: String

    /// A property that holds categories of drinks type (eg Beer, Cider etc)
    var categories: [Category]

}
