//
//  BeerItemTitleView.swift
//  Ashcott
//
//  Created by Nigel Gee on 27/05/2026.
//

import SwiftUI

/// A view that show the main text title and ABV of a drink item
struct BeerItemTitleView: View {
    let item: Drinks.Category.Item

    var body: some View {
        ViewThatFits {
            HStack(alignment: .top) {
                Text("\(item.id.dropFirst(2)) - \(item.name)")

                if let award = item.award {
                    Text(award)
                        .foregroundStyle(.white)
                        .font(.headline)
                        .padding(.horizontal, 7)
                        .background(awardColor(for: award), in: .capsule)
                        .accessibilityLabel("\(award) place")
                }

                if let abv = item.abv {
                    Spacer()
                    let newABV = abv / 100
                    HStack(spacing: 0) {
                        Text(newABV.formatted(.percent))
                        Text(" abv")
                    }
                    .accessibilityElement()
                    .accessibilityLabel("\(newABV.formatted(.percent)) abv")
                }
            }

            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text("\(item.id.dropFirst(2)) - \(item.name)")

                    if let award = item.award {
                        Text(award)
                            .foregroundStyle(.white)
                            .font(.headline)
                            .padding(.horizontal, 7)
                            .background(awardColor(for: award), in: .capsule)
                            .accessibilityLabel("\(award) place")
                    }
                }

                if let abv = item.abv {
                    Spacer()
                    let newABV = abv / 100
                    HStack(spacing: 0) {
                        Text(newABV.formatted(.percent))
                        Text(" abv")
                    }
                    .accessibilityElement()
                    .accessibilityLabel("\(newABV.formatted(.percent)) abv")
                }
            }
        }
        .font(.title3)
        .bold()
    }
    
    /// A method that detrimes the background for an `award`
    /// - Parameter award: This ca be only "1st", "2nd" or "3rd"
    /// - Returns: A color for the background of award.
    func awardColor(for award: String) -> Color {
        switch award {
        case "1st": .orange
        case "2nd": .indigo
        case "3rd": .brown
        default: .clear
        }
    }
}

#Preview("Light") {
    BeerItemTitleView(item: .example)
        .padding()
}

#Preview("Dark") {
    BeerItemTitleView(item: .example)
        .padding()
        .preferredColorScheme(.dark)
}
