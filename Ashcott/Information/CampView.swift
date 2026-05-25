//
//  CampView.swift
//  Ashcott
//
//  Created by Nigel Gee on 14/05/2026.
//

import SwiftUI

struct CampView: View {
    @State private var camp: Camping?
    @State private var loadingError = false

    @State var showLocation = false
    var body: some View {
        Group {
            if let camp {
                ScrollView {
                    AsyncImage(url: URL(string: "\(Base.url.rawValue)images/\(camp.image)")) { phase in
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

                    VStack {
                        Text(camp.welcomeTextDisplay)
                            .font(.title3)
                            .foregroundStyle(.mint)
                            .padding(.vertical)

                        Text(camp.bodyTextDisplay)
                    }
                    .padding(.horizontal)
                }
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
            async let item = try await URLSession.shared.decode(Camping.self, from: "\(Base.url.rawValue)Camping.json")
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
}

#Preview("Dark") {
    NavigationStack {
        CampView()
            .preferredColorScheme(.dark)
    }
}

