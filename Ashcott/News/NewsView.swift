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

                        if let image = item.image, let url = URL(string: API.baseURL + API.image + image) {
                            CacheAsyncImage(for: image, url: url)
                                .frame(height: 200)
                                .clipShape(.rect(cornerRadius: 15))
                        }
                    }
                    .listRowBackground(bgPurpleColor(controlDate >= item.newsDate , or: withoutColor))
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
        .environment(ImageCache())
}

#Preview("Dark") {
    NewsView(newsItems: [.example, .example2])
        .preferredColorScheme(.dark)
        .environment(ImageCache())
}
