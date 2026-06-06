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
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(.rect(cornerRadius: 10))
            } else {
                ProgressView()
                    .frame(width: 100, height: 100)
            }
        }
    }
}

#Preview("Light") {
    InfoImageView(info: .example)
}

#Preview("Dark") {
    InfoImageView(info: .example)
        .preferredColorScheme(.dark)
}
