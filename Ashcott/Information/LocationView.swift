//
//  LocationView.swift
//  Ashcott
//
//  Created by Nigel Gee on 15/05/2026.
//

import SwiftUI

struct LocationView: View {
    @State private var loc: Location?
    @State private var loadingError = false

    @State var showCamping = false

    var body: some View {
        Group {
            if let loc {
                ScrollView {
                    ZStack(alignment: .bottomTrailing) {
                        MapView(loc: loc)

                        Text("Tap for Directions")
                            .font(.caption)
                            .foregroundStyle(.white)
                            .padding(3)
                            .background(.black)
                            .clipShape(.rect(cornerRadius: 5))
                            .padding(5)
                    }
                    .containerRelativeFrame(.vertical) { length, _ in
                        length / 3
                    }

                    VStack(alignment: .leading) {
                        Text(loc.address.first)
                        Text(loc.address.second)
                        Text(loc.address.town)
                        Text(loc.address.postcode)

                        Text(loc.bodyTextDisplay)
                            .padding(.top)

                        Button {
                            showCamping.toggle()
                        } label: {
                            Text("For More Detail About Camping")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .scrollBounceBehavior(.basedOnSize)
            } else {
                LoadingView()
            }
        }
        .navigationTitle("Where…")
        .navigationBarTitleDisplayMode(.inline)
        .task { await fetch() }
        .navigationDestination(isPresented: $showCamping, destination: CampView.init)
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
            async let item = try await URLSession.shared.decode(Location.self, from: "\(Base.url.rawValue)Location.json")
            loc = try await item
        } catch {
            loadingError.toggle()
        }
    }
}

#Preview("Light") {
    NavigationStack {
        LocationView()
    }
}

#Preview("Dark") {
    NavigationStack {
        LocationView()
            .preferredColorScheme(.dark)
    }
}
