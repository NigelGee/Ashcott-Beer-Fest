//
//  NewsView.swift
//  Ashcott
//
//  Created by Nigel Gee on 14/05/2026.
//

import SwiftUI

struct NewsView: View {
    @AppStorage("controlDate") var controlDate = Date.distantPast
    let newsItems: [NewsItem]
    
    var body: some View {
        if newsItems.isNotEmpty {
            NavigationStack {
                List(newsItems.sorted()) { item in
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text(item.newsDate, style: .date)
                                .font(.title2)
                                .bold()

                            Text(item.displayDescription)
                        }

                        if let image = item.image {
                            AsyncImage(url: URL(string: "\(Base.url.rawValue)images/\(image)")) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 200)
                                        .clipShape(.rect(cornerRadius: 10))
                                } else if phase.error != nil {
                                    VStack(alignment: .leading) {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 200)
                                            .clipShape(.rect(cornerRadius: 10))
                                        Text("Unable to Load Photo")
                                    }
                                } else {
                                    ProgressView()
                                        .frame(height: 200)
                                }
                            }
                        }
                    }
                    .listRowBackground(controlDate >= item.newsDate ? nil : Color.purple.opacity(0.2))
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
