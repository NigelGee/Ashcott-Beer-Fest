//
//  Information.swift
//  Ashcott
//
//  Created by Nigel Gee on 13/05/2026.
//

import SwiftUI

struct InformationView: View {
    @AppStorage("selectedTab") var selectedTab: Tabs = .info
    @Environment(\.horizontalSizeClass) var sizeClass

    @State private var info: Information?
    @State private var loadingError = false

    @State var showContacts = false
    @State var showMap = false
    @State var showCamping = false

    var body: some View {
        NavigationStack {
            Group {
                if let info {
                    ScrollView {
                        if let url = URL(string: API.baseURL + API.image + info.image) {
                            CacheAsyncImage(for: info.image, url: url)
                                .containerRelativeFrame(.vertical) { height, axis in
                                    if sizeClass == .compact {
                                        return .infinity
                                    } else {
                                        return height * 0.3
                                    }
                                }
                                .clipShape(.rect(cornerRadius: 15))
                        }

                        VStack {
                            InfoTextView(info: info)

                            InfoButtonView(
                                info: info,
                                showCamping: $showCamping
                            )

                            InfoSponsorView(info: info)

                        }
                        .padding()
                    }
                    .scrollBounceBehavior(.basedOnSize)
                } else {
                    LoadingView()
                }
            }
            .navigationTitle("Ashcott Beer Fest")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Contact", systemImage: "person.fill") {
                        showContacts.toggle()
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button("Map", systemImage: "map") {
                        showMap.toggle()
                    }
                }

                ToolbarItem(placement: .topBarLeading) {
                    Button("Camping" , systemImage: "tent.2") {
                        showCamping.toggle()
                    }
                }
            }
            .navigationDestination(isPresented: $showContacts, destination: ContactView.init)
            .navigationDestination(isPresented: $showMap, destination: LocationView.init)
            .navigationDestination(isPresented: $showCamping, destination: CampView.init)
            .sheet(isPresented: $loadingError) {
                ErrorLoadingView {
                    await fetch()
                }
            }
        }
        .task { await fetch() }
    }

    /// Call for get JSON data from URL
    /// requires `@State private var name = [Decodable]()`
    /// and `.task { await fetch() }`
    func fetch() async {
        do  {
            async let item = try await URLSession.shared.decode(Information.self, from: API.baseURL + API.jsonFile.information, dateDecodingStrategy: .formatted(.date))
            info = try await item
        } catch {
            print("Failed to fetch data!")
        }
    }
}

#Preview("Light") {
    InformationView()
        .environment(ImageCache())
}

#Preview("Dark") {
    InformationView()
        .preferredColorScheme(.dark)
        .environment(ImageCache())
}
