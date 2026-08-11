//
//  SponsorView.swift
//  Ashcott
//
//  Created by Nigel Gee on 14/05/2026.
//

import SwiftUI

struct SponsorView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var charity: CharityDetails?
    @State private var sponsor: Sponsorship?
    @State private var loadingError = false

    var body: some View {
        NavigationStack {
            Group {
                if let charity, let sponsor {
                    ScrollView {
                        GroupBox(sponsor.mainTitle) {

                            Text(sponsor.displayDescription)

                            if let url = URL(string: API.baseURL + API.image + sponsor.image) {
                                if horizontalSizeClass == .compact {
                                    CacheAsyncImage(for: sponsor.image, url: url)
                                        .clipShape(.rect(cornerRadius: 15))
                                } else {
                                    CacheAsyncImage(for: sponsor.image, url: url)
                                        .clipShape(.rect(cornerRadius: 15))
                                        .frame(maxWidth: 500)
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

                            CharityView(charity: charity)
                        }
                    }
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
            async let sponsorItem = try await URLSession.shared.decode(Sponsorship.self, from: API.baseURL + API.jsonFile.sponsorship)
            async let charityItem = try await URLSession.shared.decode(CharityDetails.self, from: API.baseURL + API.jsonFile.charities)
            sponsor = try await sponsorItem
            charity = try await charityItem
        } catch {
            loadingError.toggle()
        }
    }
}

#Preview("Light") {
    SponsorView()
        .environment(ImageCache())
}

#Preview("Dark") {
    SponsorView()
        .preferredColorScheme(.dark)
        .environment(ImageCache())
}
