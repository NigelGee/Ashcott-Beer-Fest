//
//  ContentView.swift
//  Ashcott
//
//  Created by Nigel Gee on 13/05/2026.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("selectedTab") var selectedTab: Tabs = .info
    @AppStorage("controlDate") var controlDate = Date.distantPast

    @Environment(\.scenePhase) var scenePhase

    @State private var newsItems = [NewsItem]()

    var badgeNumber: Int {
        newsItems.count(where: { $0.newsDate >= controlDate} )
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Info", systemImage: "info.circle", value: .info, content: InformationView.init)
            Tab("News", systemImage: "newspaper", value: .news) {
                NewsView(newsItems: newsItems)
            }
            .badge(badgeNumber)
            Tab("Beers", systemImage: "mug", value: .beers, content: DrinksView.init)
            Tab("Tickets", systemImage: "ticket", value: .ticket, content: TicketView.init)
            Tab("Sponsors", systemImage: "person.3", value: .sponsors, content: SponsorsView.init)
        }
        .task { await fetch() }
        .onChange(of: selectedTab) { oldTab, newTab in
            if oldTab == .news, newTab != .news {
                controlDate = .now
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                Task { await fetch() }
            } else if selectedTab == .news {
                controlDate = .now
            }
        }
    }

    /// Call for get JSON data from URL
    /// requires `@State private var name = [Decodable]()`
    /// and `.task { await fetch() }`
    func fetch() async {
        do  {
            async let items = try await URLSession.shared.decode([NewsItem].self, from: "\(Base.url.rawValue)News.json", dateDecodingStrategy: .formatted(.date))
            newsItems = try await items
        } catch {
            print("Failed to fetch data!")
        }
    }
}

#Preview("Light") {
    ContentView()
}

#Preview("Dark") {
    ContentView()
        .preferredColorScheme(.dark)
}
