//
//  Food.swift
//  Ashcott
//
//  Created by Nigel Gee on 19/05/2026.
//

import Foundation

nonisolated struct Food: Codable {
    struct Item: Codable, Identifiable {
        var name: String
        var detail: String
        var amount: Double
        var type: String?

        var detailDisplay: LocalizedStringResource { "\(detail)" }
        var id: UUID { UUID() }
      }

      var sponsor: String
      var sponsorTel: String?
      var items: [Item]
}
