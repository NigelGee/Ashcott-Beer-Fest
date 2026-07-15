//
//  SponsorImageView.swift
//  Ashcott
//
//  Created by Nigel Gee on 07/06/2026.
//

import SwiftUI

struct SponsorImageView: View {
    let image: String

    var body: some View {
        AsyncImage(url: URL(string: API.baseURL + API.image + image)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 100, height: 100)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(.rect(cornerRadius: 10))
                    .foregroundStyle(.secondary)
            @unknown default:
                fatalError("A new image phase")
            }
        }
    }
}

#Preview("Light") {
    SponsorImageView(image: "committee.jpg")
}

#Preview("Dark") {
    SponsorImageView(image: "committee.jpg")
        .preferredColorScheme(.dark)
}
