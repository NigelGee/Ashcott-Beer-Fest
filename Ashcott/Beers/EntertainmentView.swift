//
//  EntertainmentView.swift
//  Ashcott
//
//  Created by Nigel Gee on 19/05/2026.
//

import SwiftUI

struct EntertainmentView: View {
    @State private var entertainment: Entertainment?
    @State private var loadingError = false

    var body: some View {
        Group {
            if let entertainment {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text(entertainment.displayDescription)
                            .padding(.bottom)

                        Text(entertainment.bandTitle)
                            .font(.largeTitle)

                        Text("Sponsored by: \(entertainment.displaySponsor)")

                        if let phone = entertainment.sponsorTel {
                            Link(phone, destination: URL(string: "tel:\(phone.formatted)")!)
                        }

                        Divider()
                        ForEach(entertainment.music) { music in
                            VStack(alignment: .leading) {
                                Text(music.day)
                                    .font(.title3)
                                    .bold()
                                    .padding(.bottom, 5)
                                    .underline()
                                ForEach(music.band) { band in
                                    VStack(alignment: .leading) {
                                        HStack(spacing: 0) {
                                            if let startTime = band.startTime, let endTime = band.endTime {
                                                HStack(spacing: 0) {
                                                    Text(startTime, format: .dateTime.hour().minute())
                                                    Text(" - ")
                                                    Text(endTime, format: .dateTime.hour().minute())
                                                    Text(": ")

                                                    Text(band.name)
                                                        .bold()
                                                }
                                                .foregroundStyle(currentBand(start: startTime, end: endTime))
                                            } else {
                                                Text(band.name)
                                                    .bold()
                                            }
                                        }

                                        if band.detail != nil {
                                            Text(band.displayDetail)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                    .padding(.bottom, 5)
                                }
                                Divider()
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
        .padding()
        .navigationTitle("Music and Entertainment")
        .navigationBarTitleDisplayMode(.inline)
        .task { await fetch() }
        .sheet(isPresented: $loadingError) {
            ErrorLoadingView {
                await fetch()
            }
        }
    }

    func currentBand(start: Date, end: Date) -> Color {
        let range = start...end
        if range.contains(.now) {
            return .red
        }
        return .primary
    }

    /// Call for get JSON data from URL
    /// requires `@State private var name = [Decodable]()`
    /// and `.task { await fetch() }`
    func fetch() async {
        do  {
            async let items = try await URLSession.shared.decode(Entertainment.self, from: "\(Base.url.rawValue)Entertainment.json", dateDecodingStrategy: .formatted(.dateTime))
            entertainment = try await items
        } catch {
            loadingError.toggle()
        }
    }
}

#Preview("Light") {
    NavigationStack {
        EntertainmentView()
    }
}

#Preview("Dark") {
    NavigationStack {
        EntertainmentView()
            .preferredColorScheme(.dark)
    }
}
