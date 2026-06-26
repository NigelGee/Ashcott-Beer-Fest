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

        if let untappd = item.untappd, let untappdURL = URL(string: untappd) {
            Link(destination: untappdURL) {
                HStack(spacing: 2) {
                    Text("More details on ")
                    Image(.untappdIcon)
                        .resizable()
                        .frame(width: 21, height: 21)
                        .clipShape(.rect(cornerRadius: 5))
                    Text("Untappd")
                }
            }
        }
    }
}

#Preview("Light") {
    VStack(alignment: .leading) {
        BeerItemDetailView(item: .example)
    }
}

#Preview("Dark") {
    VStack(alignment: .leading) {
        BeerItemDetailView(item: .example)
    }
    .preferredColorScheme(.dark)
}
