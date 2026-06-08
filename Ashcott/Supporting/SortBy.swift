//
//  SortBy.swift
//  Ashcott
//
//  Created by Nigel Gee on 31/05/2026.
//

import Foundation

/// An enum that determines the sort order of drinks
enum SortBy: String, CaseIterable, Identifiable {
    case barrel =       "Barrel Number "
    case ratings =      "Highest Rating"
    case alphabetical = "Alphabetical  "
    case highestABV =   "Highest ABV   "
    case lowestABV =    "Lowest ABV    "

    var id: Self { self }
}
