//
//  CharityView.swift
//  Ashcott
//
//  Created by Nigel Gee on 07/06/2026.
//

import SwiftUI

struct CharityView: View {
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

                        CharityImageView(charity: charity)

                        Text(charity.displayDetail)
                    }
                }
            }
        }
    }
}

#Preview("Light") {
    CharityView(charity: .example)
        .padding()
}

#Preview("Dark") {
    CharityView(charity: .example)
        .padding()
        .preferredColorScheme(.dark)
}
