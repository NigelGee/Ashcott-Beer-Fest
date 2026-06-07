//
//  CharityImageView.swift
//  Ashcott
//
//  Created by Nigel Gee on 07/06/2026.
//

import SwiftUI

struct CharityImageView: View {
    let charity: CharityDetails.Charity
    var body: some View {
        AsyncImage(url: URL(string: "\(Base.url.rawValue)images/\(charity.image)")) { phase in
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
    CharityImageView(charity: .example)
}

#Preview("Dark") {
    CharityImageView(charity: .example)
        .preferredColorScheme(.dark)
}
