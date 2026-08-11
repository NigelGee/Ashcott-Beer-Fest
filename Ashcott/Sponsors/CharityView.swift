//
//  CharityView.swift
//  Ashcott
//
//  Created by Nigel Gee on 07/06/2026.
//

import SwiftUI

struct CharityView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    let charity: CharityDetails
    
    var body: some View {
        GroupBox(charity.mainTitle) {
            Text(charity.displayDescription)

            ForEach(charity.charities) { charity in
                GroupBox(charity.title) {
                    VStack(alignment: .leading) {
                        if let url = charity.url {
                            Link("\(url)", destination: url)
                                .accessibilityElement()
                                .accessibilityLabel("\(charity.title) website")
                        }

                        if let url = URL(string: API.baseURL + API.image + charity.image) {
                            if horizontalSizeClass == .compact {
                                CacheAsyncImage(for: charity.image, url: url)

                                Text(charity.displayDetail)
                            } else {
                                HStack {
                                    CacheAsyncImage(for: charity.image, url: url)
                                        .frame(maxWidth: 270)

                                    Text(charity.displayDetail)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview("Light") {
    CharityView(charity: .example)
        .padding()
        .environment(ImageCache())
}

#Preview("Dark") {
    CharityView(charity: .example)
        .padding()
        .preferredColorScheme(.dark)
        .environment(ImageCache())
}
