//
//  CampView.swift
//  Ashcott
//
//  Created by Nigel Gee on 14/05/2026.
//

import SwiftUI

struct CampView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var camp: Camping?
    @State private var loadingError = false

    @State var showLocation = false
    
    var body: some View {
        Group {
            if let camp {
                ScrollView {
                    if let url = URL(string: API.baseURL + API.image + camp.image) {
                        CacheAsyncImage(for: camp.image, url: url)
                            .containerRelativeFrame(.vertical) { height, axis in
                                if sizeClass == .compact {
                                    return 160
                                } else {
                                    return height * 0.3
                                }
                            }
                            .clipShape(.rect(cornerRadius: 15))
                    }

                    VStack {
                        Text(camp.displayWelcomeText)
                            .font(.title3)
                            .foregroundStyle(.mint)
                            .padding(.vertical)

                        Text(camp.displayBodyText)
                            .padding(.bottom)
                    }
                    .padding(.horizontal)
                }
                .scrollIndicators(.hidden)
                .scrollBounceBehavior(.basedOnSize)
            } else {
                LoadingView()
            }
        }
        .navigationTitle("Camping")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Location", systemImage: "map") {
                showLocation.toggle()
            }
        }
        .navigationDestination(isPresented: $showLocation, destination: LocationView.init)
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
            async let item = try await URLSession.shared.decode(Camping.self, from: API.baseURL + API.jsonFile.camping)
            camp = try await item
        } catch {
            loadingError.toggle()
        }
    }
}

#Preview("Light") {
    NavigationStack {
        CampView()
    }
    .environment(ImageCache())
}

#Preview("Dark") {
    NavigationStack {
        CampView()
            .preferredColorScheme(.dark)
    }
    .environment(ImageCache())
}

