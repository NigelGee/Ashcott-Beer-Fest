//
//  NewsView.swift
//  Ashcott
//
//  Created by Nigel Gee on 14/05/2026.
//

import SwiftUI

struct NewsView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var withoutColor
    @AppStorage("controlDate") var controlDate = Date.distantPast
    let newsItems: [NewsItem]
    
    var body: some View {
        if newsItems.isNotEmpty {
            NavigationStack {
                List(newsItems.sorted()) { item in
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            if withoutColor, controlDate <= item.newsDate {
                                HStack {
                                    Image(systemName: "rhombus.fill")
                                    
                                    Text(item.newsDate, style: .date)
                                        .font(.title2)
                                        .bold()
                                }

                                Text(item.displayDescription)
                            } else {
                                Text(item.newsDate, style: .date)
                                    .font(.title2)
                                    .bold()

                                Text(item.displayDescription)
                            }
                        }

                        NewsImageView(item: item)

                    }
                    .listRowBackground(
                        controlDate >= item.newsDate ? nil
                        : withoutColor ? nil : Color.purple.opacity(0.2)
                    )
                }
                .navigationTitle("Latest News…")
            }
        } else {
            LoadingView()
        }
    }
}

#Preview("Light") {
    NewsView(newsItems: [.example, .example2])
}

#Preview("Dark") {
    NewsView(newsItems: [.example, .example2])
        .preferredColorScheme(.dark)
}
