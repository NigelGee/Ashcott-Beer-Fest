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

    static let example = NewsItem(
        newsDate: .now,
        description: "This year Saturday theme is:-\n **Down on the Farm**.",
        image:  "farmerBully.png"
    )

    static let example2 = NewsItem(
        newsDate: .now,
        description: "[Camping registration form now available to book your camping.](https://docs.google.com/forms/d/e/1FAIpQLSczKZgcVQyzllXyRiDzlN2Y7n29PqDDNf6sczvFDjHjnVLKVg/viewform?pli=1)",
    )
}
