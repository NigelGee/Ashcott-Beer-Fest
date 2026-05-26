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
                                    HStack(alignment: .top) {
                                        Text("\(item.id.dropFirst(2)) - \(item.displayName)")

                                        if let award = item.award {
                                            Text(award)
                                                .foregroundStyle(.white)
                                                .font(.headline)
                                                .padding(.horizontal, 7)
                                                .background(awardColor(for: award), in: .capsule)
                                        }


                                        if let abv = item.abv {
                                            Spacer()
                                            let newABV = abv / 100
                                            HStack(spacing: 0) {
                                                Text(newABV.formatted(.percent))
                                                Text(" abv")
                                            }
                                        }
                                    }
                                    .font(.title3)
                                    .bold()

                                    if item.brewer != nil {
                                        Text(item.displayBrewer)
                                            .font(.headline)
                                            .foregroundStyle(.indigo)
                                    }

                                    Text(item.displayDetail)


                                    if item.sponsor != nil {
                                        HStack(spacing: 0) {
                                            Text("Sponsor by: ")
                                                .foregroundStyle(.secondary)
                                            Text(item.displaySponsor)
                                                .foregroundStyle(.indigo)
                                        }
                                    }

                                    if let phone = item.sponsorTel {
                                        Link("Telephone: \(phone)", destination: URL(string: "tel:\(phone.formatted)")!)
                                    }

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
                                                }

                                                Spacer()
                                            }
                                            .background(.cyan.gradient, in: .capsule)
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
                    .scrollIndicators(.hidden)
                    .scrollBounceBehavior(.basedOnSize)
                } else {
                    LoadingView()
                }
            }
            .padding()
            .navigationTitle("Ales and Cider")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await fetch()
                purgeRatedDrinks()
            }
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
            .navigationDestination(isPresented: $showFood) {
                FoodView()
            }
            .navigationDestination(isPresented: $showMusic) {
                EntertainmentView()
            }
            .sheet(item: $rateDrinkItem) { item in
                RateDrinksView(drink: item)
                    .presentationDetents([.medium])
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
                ErrorLoadingView {
                    await fetch()
                }
            }
            .onChange(of: scenePhase) {
                if scenePhase == .active {
                    Task {
                        await fetch()
                    }
                }
            }
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
        case "checkmark.circle": .red
        case "circle": .orange
        default: .primary
        }
    }

    func awardColor(for award: String) -> Color {
        switch award {
        case "1st": .orange
        case "2nd": .indigo
        case "3rd": .brown
        default: .red
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
