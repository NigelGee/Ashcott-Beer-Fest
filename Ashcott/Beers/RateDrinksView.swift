//
//  RateDrinksView.swift
//  Ashcott
//
//  Created by Nigel Gee on 21/05/2026.
//

import SwiftData
import SwiftUI

struct RateDrinksView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext

    @AppStorage("rateTotal") var rateTotal = 5
    @AppStorage("symbol") var symbol = "star"

    let drink: Drinks.Category.Item

    @State private var currentRating = 1

    var symbolColor: Color {
        switch symbol {
        case "star": .purple
        case "heart": .red
        case "mug": .brown
        case "checkmark.circle": .indigo
        case "circle": .orange
        default: .primary
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            HStack(spacing: 0) {
                Spacer()
                Text("Rate out of:")
                Picker("Rate out of:", selection: $rateTotal) {
                    Text("Five").tag(5)
                    Text("Ten").tag(10)
                }

                Picker(selection: $symbol) {
                    Text("Stars").tag("star")
                    Text("Hearts").tag("heart")
                    Text("Mugs").tag("mug")
                    Text("Checkmarks").tag("checkmark.circle")
                    Text("Circles").tag("circle")
                } label: {
                    Image(systemName: symbol)
                }

            }

            Text("\(drink.id.dropFirst(2)) - \(drink.name)")
                .font(.largeTitle)
            
            if drink.brewer != nil {
                Text(drink.displayBrewer)
                    .padding(.top, -35)
                    .font(.title3)
            }

            HStack {
                ForEach(0..<rateTotal, id: \.self) { rating in
                    Image(systemName: symbol)
                        .symbolVariant(rating < currentRating ? .fill : .none)
                        .imageScale(.large)
                        .padding(.vertical)
                        .foregroundStyle(symbolColor)
                        .onTapGesture {
                            currentRating = rating + 1
                        }
                        .accessibilityElement()
                        .accessibilityLabel("^[\(rating + 1) rating](inflect: true)")
                        .dynamicTypeSize(..<DynamicTypeSize.xLarge)
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .background(.cyan.gradient, in: .capsule)

            Button {
                confirm()
            } label: {
                Text("Confirm")
                    .font(.title3)
                    .padding(.vertical, 5)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding(.horizontal)
    }

    func confirm() {
        let ratedDrink = RatedDrink(id: drink.id, rate: currentRating, total: rateTotal, symbol: symbol)
        modelContext.insert(ratedDrink)
        try? modelContext.save()
        dismiss()
    }
}

#Preview("Light") {
    NavigationStack {
        RateDrinksView(drink: .example)

    }
}

#Preview("Dark") {
    NavigationStack {
        RateDrinksView(drink: .example)
    }
    .preferredColorScheme(.dark)
}
