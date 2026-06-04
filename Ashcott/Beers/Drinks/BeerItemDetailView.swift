//
//  BeerItemDetailView.swift
//  Ashcott
//
//  Created by Nigel Gee on 27/05/2026.
//

import SwiftUI

/// A view that show the detaiL of a drink item
struct BeerItemDetailView: View {
    let item: Drinks.Category.Item

    var body: some View {
        if item.brewer != nil {
            Text(item.displayBrewer)
                .font(.headline)
                .foregroundStyle(.indigo)
        }

        Text(item.displayDetail)

        if item.sponsor != nil {
            HStack(spacing: 0) {
                Text("Sponsored by: ")
                    .foregroundStyle(.secondary)
                Text(item.displaySponsor)
                    .foregroundStyle(.indigo)
            }
            .accessibilityElement()
            .accessibilityLabel("Sponsored by \(item.displaySponsor)")
        }

        if let phone = item.sponsorTel {
            Link("Telephone: \(phone)", destination: URL(string: "tel:\(phone.formatted)")!)
        }
    }
}

#Preview {
    VStack(alignment: .leading) {
        BeerItemDetailView(item: .example)
    }
}
