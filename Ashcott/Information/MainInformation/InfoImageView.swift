//
//  InfoImageView.swift
//  Ashcott
//
//  Created by Nigel Gee on 06/06/2026.
//

import SwiftUI

struct InfoImageView: View {
    let image: String

    var body: some View {
        AsyncImage(url: URL(string: API.baseURL + API.image + image)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 160, height: 160)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                    .clipShape(.rect(cornerRadius: 10))
                    .foregroundStyle(.secondary)
            @unknown default:
                fatalError("a new image phase")
            }
        }
    }
}

#Preview("Light") {
    VStack {
        InfoImageView(image: "header.png")
        InfoImageView(image: "downOnTheFarm.png")
    }
}

#Preview("Dark") {
    InfoImageView(image: "header.png")
    InfoImageView(image: "downOnTheFarm.png")
        .preferredColorScheme(.dark)
}
