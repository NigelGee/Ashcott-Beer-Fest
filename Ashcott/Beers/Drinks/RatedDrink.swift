//
//  RatedDrink.swift
//  Ashcott
//
//  Created by Nigel Gee on 21/05/2026.
//

import SwiftUI
import SwiftData

@Model
final class RatedDrink {
    /// A property that holds a id of selected drink item
    ///
    /// This is a two digit year and the barrel number eg (2501)
    var id: String

    /// A property that holds the rating of selected drink item
    var rate: Int

    /// A property that holds the total rating of selected drink item
    ///
    /// This can be five or ten
    var total: Int

    /// A property that holds the chosen symbol for selected drink item
    ///
    /// The symbol used are:-
    /// - star
    /// - heart
    /// - checkmark,circle
    /// - mug
    /// - circle
    var symbol: String

    /// A property that holds date that a selected drink item was created
    ///
    /// This is used to purge old drink ratings
    var createdOn: Date

    init(id: String, rate: Int, total: Int, symbol: String, createdOn: Date = .now) {
        self.id = id
        self.rate = rate
        self.total = total
        self.symbol = symbol
        self.createdOn = createdOn
    }
}
