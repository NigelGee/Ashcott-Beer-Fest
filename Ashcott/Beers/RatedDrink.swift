//
//  RatedDrink.swift
//  Ashcott
//
//  Created by Nigel Gee on 21/05/2026.
//

import SwiftUI
import SwiftData

@Model
class RatedDrink {
    var id: String
    var rate: Int
    var total: Int
    var symbol: String
    var createdOn: Date

    init(id: String, rate: Int, total: Int, symbol: String, createdOn: Date = .now) {
        self.id = id
        self.rate = rate
        self.total = total
        self.symbol = symbol
        self.createdOn = createdOn
    }
}
