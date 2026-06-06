//
//  Food.swift
//  Ashcott
//
//  Created by Nigel Gee on 19/05/2026.
//

import Foundation

nonisolated struct Food: Codable {
    struct Item: Codable, Identifiable {

        /// A property for the food item name
        var name: String

        /// A property for information about food item
        var detail: String

        /// A property for price of a food item
        var amount: Double

        /// A property for the type of food item
        ///
        /// For type leave space between the types. Use;-
        /// - G for Gluten Free
        /// - V for Vegetarian
        /// - Ve for Vegan
        var type: String?
        
        /// A property that holds ``detail`` of the drink item
        ///
        /// - Note: This converts text to display as markdown
        var displayDetail: LocalizedStringResource { "\(detail)" }

        var id: UUID { UUID() }
    }
    
    /// A property that shows the sponsor of Food
    var sponsor: String

    /// A property that shows the sponsor telephone number if provided
    var sponsorTel: String?

    /// An array of food items
    var items: [Item]
    
    /// A property that holds ``sponsor`` of the drink item
    ///
    /// - Note: This converts text to display as markdown
    var displaySponsor: LocalizedStringResource { "\(sponsor)" }
}
