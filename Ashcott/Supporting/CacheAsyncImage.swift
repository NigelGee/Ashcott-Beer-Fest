//
//  CacheAsyncImage.swift
//  Ashcott
//
//  Created by Nigel Gee on 11/08/2026.
//

import SwiftUI

private enum LoadingPhase {
    case empty
    case success(UIImage)
    case failure
}

struct CacheAsyncImage: View {
    @Environment(ImageCache.self) var imageCache

    let cacheKey: String
    let url: URL

    init(for cacheKey: String, url: URL) {
        self.cacheKey = cacheKey
        self.url = url
    }

    @State private var phase: LoadingPhase = .empty

    var body: some View {
        Group {
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.secondary)
            }
        }
        .task {
            await loadImage()
        }
    }

    private func loadImage() async {
        phase = .empty

        if let cachedImage = imageCache.image(forKey: cacheKey) {
            phase = .success(cachedImage)
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let response = response as? HTTPURLResponse, 200...300 ~= response.statusCode else {
                phase = .failure
                return
            }

            guard let image = UIImage(data: data) else {
                phase = .failure
                return
            }
            imageCache.insert(image, forKey: cacheKey)
            phase = .success(image)
        } catch {
            phase = .failure
        }
    }
}

#Preview("Light") {
    CacheAsyncImage(
        for: "farmerBully.png",
        url: URL(string: API.baseURL + API.image + "farmerBully.png")!
    )
    .environment(ImageCache())
}

#Preview("Dark") {
    CacheAsyncImage(
        for: "farmerBully.png",
        url: URL(string: API.baseURL + API.image + "farmerBully.png")!
    )
    .environment(ImageCache())
    .preferredColorScheme(.dark)
}
