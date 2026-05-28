//
//  SponsorsView.swift
//  Ashcott
//
//  Created by Nigel Gee on 14/05/2026.
//

import SwiftUI

struct SponsorsView: View {
    @State private var charity: CharityDetails?
    @State private var sponsor: Sponsorship?
    @State private var loadingError = false

    var body: some View {
        NavigationStack {
            Group {
                if let charity, let sponsor {
                    ScrollView {
                        GroupBox(sponsor.mainTitle) {
                            Text(sponsor.descriptionDisplay)
                            AsyncImage(url: URL(string: "\(Base.url.rawValue)images/\(sponsor.image)")) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } else if phase.error != nil {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .clipShape(.rect(cornerRadius: 10))
                                } else {
                                    ProgressView()
                                        .frame(width: 100, height: 100)
                                }
                            }

                            GroupBox(sponsor.yearTitle) {
                                GroupBox {
                                    VStack(alignment: .leading) {
                                        ForEach(sponsor.sponsors.sorted()) { sponsor in
                                            if let url = sponsor.url {
                                                Link(sponsor.name, destination: url)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                            } else {
                                                Text(sponsor.name)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                            }
                                        }
                                    }
                                }
                            }

                            GroupBox(charity.mainTitle) {
                                Text(charity.descriptionDisplay)

                                ForEach(charity.charities) { charity in
                                    GroupBox(charity.title) {
                                        VStack(alignment: .leading) {
                                            if let url = charity.url {
                                                Link("\(url)", destination: url)
                                                    .accessibilityElement()
                                                    .accessibilityLabel("\(charity.title) website")
                                            }

                                            AsyncImage(url: URL(string: "\(Base.url.rawValue)images/\(charity.image)")) { phase in
                                                if let image = phase.image {
                                                    image
                                                        .resizable()
                                                        .scaledToFit()
                                                } else if phase.error != nil {
                                                    Image(systemName: "photo")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 100, height: 100)
                                                        .clipShape(.rect(cornerRadius: 10))
                                                } else {
                                                    ProgressView()
                                                        .frame(width: 100, height: 100)
                                                }
                                            }

                                            Text(charity.detailDisplay)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    .scrollBounceBehavior(.basedOnSize)
                } else {
                    LoadingView()
                }
            }
            .navigationTitle("Charities and Sponsors")
            .task { await fetch() }
            .sheet(isPresented: $loadingError) {
                ErrorLoadingView {
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
            async let sponsorItem = try await URLSession.shared.decode(Sponsorship.self, from: "\(Base.url.rawValue)Sponsorship.json")
            async let charityItem = try await URLSession.shared.decode(CharityDetails.self, from: "\(Base.url.rawValue)Charities.json")
            sponsor = try await sponsorItem
            charity = try await charityItem
        } catch {
            loadingError.toggle()
        }
    }
}

#Preview("Light") {
    SponsorsView()
}

#Preview("Dark") {
    SponsorsView()
        .preferredColorScheme(.dark)
}
