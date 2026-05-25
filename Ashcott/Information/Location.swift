//
//  Location.swift
//  Ashcott
//
//  Created by Nigel Gee on 16/05/2026.
//

import Foundation
import MapKit

nonisolated struct Location: Codable {
    struct Address: Codable {
        var first: String
        var second: String
        var town: String
        var postcode: String
    }

    var name: String
    var longitude: Double
    var latitude: Double
    var address: Address
    var bodyText: String

    var bodyTextDisplay: LocalizedStringResource { "\(bodyText)" }
    var coordinates: CLLocationCoordinate2D { .init(latitude: latitude, longitude: longitude) }

    static let example = Location(
        name: "Ashcott Beer Fest",
        longitude: -2.8168881058230903,
        latitude: 51.13170009119376,
        address: Address(
            first: "Ashcott Playing Fields",
            second: "Kings Lane",
            town: "Ascott",
            postcode: "TA7 9QT"
        ),
        bodyText: "**By Car**\nFrom M5 exit at junction 23 toward Glastonbury and Wells, when you reach Ascott, look out for the signs to Beer Fest. There is car parking space at the site. Please be responsible driver.\n\n**Camping**\nCamping is available right next door to the Beer Fest site.\n[This year all camping must be booked prior to the event here.](https://docs.google.com/forms/d/e/1FAIpQLSczKZgcVQyzllXyRiDzlN2Y7n29PqDDNf6sczvFDjHjnVLKVg/viewform)"
    )
}
