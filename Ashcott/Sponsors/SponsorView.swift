//
//  SponsorView.swift
//  Ashcott
//
//  Created by Nigel Gee on 14/05/2026.
//

import SwiftUI

struct SponsorView: View {
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

                            SponsorImageView(sponsor: sponsor)

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
    SponsorView()
}

#Preview("Dark") {
    SponsorView()
        .preferredColorScheme(.dark)
}
