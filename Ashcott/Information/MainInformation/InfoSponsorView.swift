//
//  InfoSponsorView.swift
//  Ashcott
//
//  Created by Nigel Gee on 06/06/2026.
//

import SwiftUI

struct InfoSponsorView: View {
    @AppStorage("selectedTab") var selectedTab: Tabs = .info
    let info: Information

    var body: some View {
        GroupBox {
            Text(info.displayHelpTitle)
                .font(.title2)

            GroupBox(info.volunteersTitle) {
                Text(info.displayVolunteersText)
            }

            Button {
                selectedTab = .sponsors
            } label: {
                GroupBox(info.sponsorTitle) {
                    Text(info.displaySponsorText)
                }
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview("Light") {
    InfoSponsorView(info: .example)
        .padding(.horizontal)
}

#Preview("Dark") {
    InfoSponsorView(info: .example)
        .padding(.horizontal)
        .preferredColorScheme(.dark)
}
