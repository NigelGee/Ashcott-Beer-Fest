//
//  DrinksView.swift
//  Ashcott
//
//  Created by Nigel Gee on 01/06/2026.
//

import SwiftData
import SwiftUI
import TipKit

/// A view that show 'Drinks' information
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
    @State private var deletedRatedName = "this item"

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
                                // A sort menu to display drink in different order
                                Menu("Sorted by: \(sortBy.rawValue)") {
                                    Picker("Choose", selection: $sortBy) {
                                        ForEach(SortBy.allCases) {
                                            Text($0.rawValue)
                                        }
                                    }
                                }
                            }
                            .padding(.top, 5)
                        }
                        .padding([.horizontal, .top])

                        VStack(alignment: .leading) {
                            ForEach(drinks.categories) { category in
                                Section {
                                    ForEach(sortedItems(by: category)) { item in

                                        BeerItemTitleView(item: item)
                                            .blur(radius: item.onSale ? 0 : 3)
                                            .strikethrough(item.soldOut)

                                        BeerItemDetailView(item: item)
                                            .blur(radius: item.onSale ? 0 : 3)

                                        // If a drink item can be rated this will show either the a button to rate or the rating of the drink item
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
                                                    deletedRatedName = item.name
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
                                                .disabled(!item.onSale)
                                            }
                                        }

                                        Divider()
                                            .padding(.top)

                                    }
                                } header: {
                                    Text(category.title)
                                        .font(.title)
                                        .bold()
                                        .padding(.bottom, 5)
                                }
                            }

                            VStack(alignment: .leading) {
                                // A link to previous drink on Ashcott Beer fest site
                                Text("[View previous years beers list](https://www.ashcottbeerfest.org/page8.html)")
                                    .padding(.bottom)

                                // A button to reset all drink item ratings
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
                Task {  await fetch() }
            }
        }
    }

    /// Call for get JSON data from URL
    /// requires `@State private var name = [Decodable]()`
    /// and `.task { await fetch() }`
    func fetch() async {
        do  {
            async let drinkItems = try await URLSession.shared.decode(Drinks.self, from: API.baseURL + API.jsonFile.drinks)
            drinks = try await drinkItems
        } catch {
            loadingError.toggle()
        }
    }

    /// A method to determine the color of ratings symbols
    /// - Parameter symbol: the symbol user selected
    /// - Returns: A color for the symbol
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

    /// A method delete all ratings
    func deleteRatings() {
        for ratedDrink in ratedDrinks {
            modelContext.delete(ratedDrink)
        }
        try? modelContext.save()
    }
    
    /// A method to delete a single rating
    /// - Parameter ratedDrinkID: The rating id to be deleted
    func deleteRating(for ratedDrinkID: String) {
        for ratedDrink in ratedDrinks where ratedDrink.id == ratedDrinkID {
            modelContext.delete(ratedDrink)
            try? modelContext.save()
        }
    }
    
    /// A method to delete all old ratings to kept database as small as possible
    func purgeRatedDrinks() {
        for ratedDrink in ratedDrinks where ratedDrink.createdOn < .now.add(year: -1) {
            modelContext.delete(ratedDrink)
        }

        try? modelContext.save()
    }

    /// A method to sort drink items
    /// - Parameter category: a category of drink items
    /// - Returns: Sort by the chosen type.
    func sortedItems(by category: Drinks.Category) -> [Drinks.Category.Item] {
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
        case .alphabetical:
            category.items.sorted { item1, item2 in
                item1.name < item2.name
            }
        case .highestABV:
            category.items.sorted { item1, item2 in
                if let abv1 = item1.abv, let abv2 = item2.abv {
                    return abv1 > abv2
                }
                return false
            }
        case .lowestABV:
            category.items.sorted { item1, item2 in
                if let abv1 = item1.abv, let abv2 = item2.abv {
                    return abv1 < abv2
                }
                return false
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
