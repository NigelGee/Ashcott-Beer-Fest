//
//  DrinksView.swift
//  Ashcott
//
//  Created by Nigel Gee on 01/06/2026.
//

import SwiftData
import SwiftUI
import TipKit

struct DrinksView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.scenePhase) var scenePhase
    @AppStorage("sortBy") var sortBy: SortBy = .barrel

    @State private var showFood = false
    @State private var showMusic = false
    @State private var showResetAlert = false

    @State private var drinks: Drinks?
    @State private var loadingError = false

    @State private var showDeleteRating = false
    @State private var deletedRatedDrink = ""
    @State private var deletedRatedName: LocalizedStringResource = "this item"

    @Query var ratedDrinks: [RatedDrink]

    @State private var rateDrinkItem: Drinks.Category.Item?

    let deleteRatingsTip = DeleteRatingsTip()

    var body: some View {
        NavigationStack {
            Group {
                if let drinks {
                    ScrollView {
                        VStack(alignment: .leading) {
                            Text(drinks.title)
                                .font(.title)
                                .padding(.bottom)

                            Text(drinks.description)

                            Divider()

                            HStack {
                                Spacer()

                                Menu("Sorted by: \(sortBy.rawValue)") {
                                    Picker("Sort", selection: $sortBy) {
                                        ForEach(SortBy.allCases, id: \.self) { t in
                                            Text(t.rawValue)

                                        }
                                    }
                                }
                            }
                        }
                        .padding([.horizontal, .top])

                        VStack(alignment: .leading) {
                            ForEach(drinks.categories) { category in
                                Text(category.title)
                                    .font(.title)
                                    .bold()
                                    .padding(.bottom, 5)

                                ForEach(sortedItems(category: category)) { item in

                                    BeerItemTitleView(item: item)

                                    BeerItemDetailView(item: item)

                                    if item.canRate {
                                        if let ratedDrink = ratedDrinks.first(where: { $0.id == item.id } ) {
                                            HStack {
                                                Spacer()

                                                ForEach(0..<ratedDrink.total, id:\.self) { i in
                                                    Image(systemName: ratedDrink.symbol)
                                                        .symbolVariant(ratedDrink.rate > i ? .fill : .none)
                                                        .imageScale(.large)
                                                        .padding(.vertical, 5)
                                                        .foregroundStyle(symbolColor(for: ratedDrink.symbol))
                                                        .dynamicTypeSize(..<DynamicTypeSize.xLarge)
                                                }

                                                Spacer()
                                            }
                                            .background(.cyan.gradient, in: .capsule)
                                            .onLongPressGesture {
                                                deletedRatedName = item.displayName
                                                deletedRatedDrink = ratedDrink.id
                                                deleteRatingsTip.invalidate(reason: .actionPerformed)
                                                showDeleteRating.toggle()
                                            }
                                            .accessibilityElement()
                                            .accessibilityLabel("\(ratedDrink.rate) out of \(ratedDrink.total)")
                                            .accessibilityHint("Long press to delete ratings")
                                            .popoverTip(deleteRatingsTip, arrowEdge: .top)
                                        } else {
                                            Button {
                                                rateDrinkItem = item
                                            } label: {
                                                Text("Not Rated")
                                                    .frame(maxWidth: .infinity, alignment: .center)
                                            }
                                            .buttonStyle(.bordered)
                                        }
                                    }

                                    Divider()
                                        .padding(.top)
                                }
                            }

                            VStack(alignment: .leading) {
                                Text("[View previous years beers list](https://www.ashcottbeerfest.org/page8.html)")
                                    .padding(.bottom)

                                Button {
                                    showResetAlert.toggle()
                                } label: {
                                    Text("Reset Ratings")
                                        .font(.title3)
                                        .padding(.vertical, 5)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .background(.red.gradient, in: .capsule)
                                        .foregroundStyle(.white)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal)
                    }
                } else {
                   LoadingView()
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            .navigationTitle("Ales and Cider")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Entertainment", systemImage: "music.quarternote.3") {
                        showMusic.toggle()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Food", systemImage: "fork.knife") {
                        showFood.toggle()
                    }
                }
            }
            .navigationDestination(isPresented: $showFood, destination: FoodView.init)
            .navigationDestination(isPresented: $showMusic, destination: EntertainmentView.init)
        }
        .task {
            await fetch()
            purgeRatedDrinks()
        }
        .sheet(isPresented: $loadingError) {
            ErrorLoadingView {
                await fetch()
            }
        }
        .sheet(item: $rateDrinkItem) { item in
            RateDrinksView(drink: item)
                .dynamicSheetDetent()
                .presentationBackground(.thickMaterial)
        }
        .alert("Reset Ratings!", isPresented: $showResetAlert) {
            Button(role: .destructive) {
                deleteRatings()
            } label: {
                Text("Reset")
                    .foregroundStyle(.red)
            }
        } message: {
            Text("This will delete all ratings that have been set!\n\nThis operation can not be undone.")
        }
        .alert("Delete Ratings", isPresented: $showDeleteRating) {
            Button(role: .destructive) {
                deleteRating(for: deletedRatedDrink)
            } label: {
                Text("Delete")
            }
        } message: {
            Text("Are you sure you want to delete the rating for \(deletedRatedName)?\n\nThis action can not be undone!")
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                Task {
                    await fetch()
                }
            }
        }
    }

    /// Call for get JSON data from URL
    /// requires `@State private var name = [Decodable]()`
    /// and `.task { await fetch() }`
    func fetch() async {
        do  {
            async let drinkItems = try await URLSession.shared.decode(Drinks.self, from: "\(Base.url.rawValue)Drinks.json")
            drinks = try await drinkItems
        } catch {
            loadingError.toggle()
        }
    }

    func deleteRatings() {
        for ratedDrink in ratedDrinks {
            modelContext.delete(ratedDrink)
        }
        try? modelContext.save()
    }

    func symbolColor(for symbol: String) -> Color {
        switch symbol {
        case "star": .purple
        case "heart": .red
        case "mug": .brown
        case "checkmark.circle": .indigo
        case "circle": .orange
        default: .primary
        }
    }

    func deleteRating(for ratedDrinkID: String) {
        for ratedDrink in ratedDrinks where ratedDrink.id == ratedDrinkID {
            modelContext.delete(ratedDrink)
            try? modelContext.save()
        }
    }

    func purgeRatedDrinks() {
        for ratedDrink in ratedDrinks where ratedDrink.createdOn < .now.add(year: -1) {
            modelContext.delete(ratedDrink)
        }

        try? modelContext.save()
    }

    func sortedItems(category: Drinks.Category) -> [Drinks.Category.Item] {
        switch sortBy {
        case .barrel:
            category.items.sorted()
        case .ratings:
            category.items.sorted { item1, item2 in
                if let ratedDrink1 = ratedDrinks.first(where: { $0.id == item1.id } ) {
                    if let ratedDrink2 = ratedDrinks.first(where:  { $0.id == item2.id} ) {
                        let absRating1 = Double(ratedDrink1.rate) / Double(ratedDrink1.total)
                        let absRating2 = Double(ratedDrink2.rate) / Double(ratedDrink2.total)

                        return absRating1 > absRating2
                    } else {
                        return true
                    }
                } else if ratedDrinks.first(where: { $0.id != item2.id } ) == nil {
                    return false
                } else {
                    return item1.id < item2.id
                }
            }
        }
    }
}

#Preview("Light") {
    DrinksView()
}

#Preview("Dark") {
    DrinksView()
        .preferredColorScheme(.dark)
}
