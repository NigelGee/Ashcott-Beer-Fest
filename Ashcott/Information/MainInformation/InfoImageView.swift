//
//  InfoImageView.swift
//  Ashcott
//
//  Created by Nigel Gee on 06/06/2026.
//

import SwiftUI

struct InfoImageView: View {
    let info: Information

    var body: some View {
        AsyncImage(url: URL(string: "\(Base.url.rawValue)images/\(info.image)")) { phase in
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
        InfoImageView(info: .example)
        InfoImageView(info: .imageExample)
    }
}

#Preview("Dark") {
    InfoImageView(info: .example)
    InfoImageView(info: .imageExample)
        .preferredColorScheme(.dark)
}
