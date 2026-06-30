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
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(height: 200)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .clipShape(.rect(cornerRadius: 10))
                case .failure:
                    VStack(alignment: .leading) {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .clipShape(.rect(cornerRadius: 10))
                            .foregroundStyle(.secondary)
                        Text("Unable to Load Photo")
                    }
                @unknown default:
                    fatalError("a new image phase")
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

