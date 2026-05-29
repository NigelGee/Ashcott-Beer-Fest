//
//  BeersView.swift
//  Ashcott
//
//  Created by Nigel Gee on 14/05/2026.
//

import SwiftData
import SwiftUI

struct BeersView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.scenePhase) var scenePhase
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
                            ForEach(drinks.categories) { category in
                                Text(category.title)
                                    .font(.title)
                                    .bold()
                                    .padding(.bottom, 5)

                                ForEach(category.items.sorted()) { item in

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
                                                showDeleteRating.toggle()
                                            }
                                            .accessibilityElement()
                                            .accessibilityLabel("\(ratedDrink.rate) out of \(ratedDrink.total)")
                                            .accessibilityHint("Long press to delete ratings")
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
                                }

                                Divider()
                                    .padding(.top)
                            }

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
                    .padding()
                    .scrollIndicators(.hidden)
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

        .sheet(item: $rateDrinkItem) { item in
            RateDrinksView(drink: item)
                .dynamicSheetDetent()
                .presentationBackground(.thickMaterial)
        }
        .alert("Are You Sure?", isPresented: $showResetAlert) {
            Button(role: .destructive) {
                deleteRatings()
            } label: {
                Text("Reset")
                    .foregroundStyle(.red)
            }
        } message: {
            Text("This operation can not be undone.")
        }
        .sheet(isPresented: $loadingError) {
            ErrorLoadingView { await fetch() }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                Task {
                    await fetch()
                }
            }
        }
        .alert("Delete Ratings", isPresented: $showDeleteRating) {
            Button(role: .destructive) {
                deleteRating(for: deletedRatedDrink)
            } label: {
                Text("Delete")
            }
        } message: {
            Text("Are you sure you want to delete the rating for \(deletedRatedName)? This action can not be undone!")
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

    /// Call for get JSON data from URL
    /// requires `@State private var name = [Decodable]()`
    /// and `.task { await fetch() }`
    func fetch() async {
        do  {
            async let items = try await URLSession.shared.decode(Drinks.self, from: "\(Base.url.rawValue)Drinks.json")
            drinks = try await items
        } catch {
            loadingError.toggle()
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
}

#Preview("Light") {
    BeersView()
}

#Preview("Dark") {
    BeersView()
        .preferredColorScheme(.dark)
}
