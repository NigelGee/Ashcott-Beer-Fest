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
                    .frame(width: 160, height: 160)
                    .clipShape(.rect(cornerRadius: 10))
            } else {
                ProgressView()
                    .frame(width: 160, height: 160)
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
