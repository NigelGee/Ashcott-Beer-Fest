//
//  NewsItem.swift
//  Ashcott
//
//  Created by Nigel Gee on 18/05/2026.
//

import Foundation

struct NewsItem: Codable, Identifiable, Comparable {
    var newsDate: Date
    private var description: String
    var image: String?

    var id: UUID { UUID() }
    var displayDescription: LocalizedStringResource { "\(description)" }

    static func <(lhs: NewsItem, rhs: NewsItem) -> Bool {
        lhs.newsDate > rhs.newsDate
    }

    static let example = NewsItem(newsDate: .now, description: "", image: "")
}
