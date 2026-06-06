//
//  NewsImageView.swift
//  Ashcott
//
//  Created by Nigel Gee on 06/06/2026.
//

import SwiftUI

struct NewsImageView: View {
    let item: NewsItem

    var body: some View {
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
}

#Preview("Light") {
    NewsImageView(item: .example)
}

#Preview("Dark") {
    NewsImageView(item: .example)
        .preferredColorScheme(.dark)
}

