//
//  SponsorImageView.swift
//  Ashcott
//
//  Created by Nigel Gee on 07/06/2026.
//

import SwiftUI

struct SponsorImageView: View {
    let sponsor: Sponsorship
    
    var body: some View {
        AsyncImage(url: URL(string: "\(Base.url.rawValue)images/\(sponsor.image)")) { phase in
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
    SponsorImageView(sponsor: .example)
}

#Preview("Dark") {
    SponsorImageView(sponsor: .example)
        .preferredColorScheme(.dark)
}
