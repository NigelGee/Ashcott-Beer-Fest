//
//  FoodView.swift
//  Ashcott
//
//  Created by Nigel Gee on 19/05/2026.
//

import SwiftUI

struct FoodView: View {
//    let food = Bundle.main.decode(Food.self, from: "Food.json")
    @State private var food: Food?
    @State private var loadingError = false


    var body: some View {
        Group {
            if let food {
                ScrollView {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text("Sponsor by: **\(food.sponsor)**")
                                .font(.title3)
                            if let phone = food.sponsorTel {
                                Link(phone, destination: URL(string: "tel:\(phone.formatted)")!)
                            }
                        }
                        .padding(.bottom)

                        Divider()

                        ForEach(food.items) { item in
                            HStack {
                                Text(item.name)

                                if let type = item.type {
                                    HStack {
                                        ForEach(type.components(separatedBy: " "), id: \.self) { text in
                                            Text(text)
                                                .bgColor(for: text)
                                        }
                                    }
                                }

                                Spacer()

                                Text(item.amount, format: .currency(code: "GBP"))
                            }
                            .font(.title2)

                            Text(item.detailDisplay)
                                .foregroundStyle(.secondary)

                            Divider()
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .scrollBounceBehavior(.basedOnSize)
            } else {
                LoadingView()
            }
        }
        .padding()
        .navigationTitle("Menu")
        .navigationBarTitleDisplayMode(.inline)
        .task { await fetch() }
        .sheet(isPresented: $loadingError) {
            ErrorLoadingView {
                await fetch()
            }
        }
    }

    /// Call for get JSON data from URL
    /// requires `@State private var name = [Decodable]()`
    /// and `.task { await fetch() }`
    func fetch() async {
        do  {
            async let items = try await URLSession.shared.decode(Food.self, from: "\(Base.url.rawValue)Food.json")
            food = try await items
        } catch {
            print("Failed to fetch data!")
        }
    }
}

#Preview("Light") {
    NavigationStack {
        FoodView()
    }
}

#Preview("Dark") {
    NavigationStack {
        FoodView()
            .preferredColorScheme(.dark)
    }
}
