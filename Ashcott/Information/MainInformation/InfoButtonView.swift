//
//  InfoButtonView.swift
//  Ashcott
//
//  Created by Nigel Gee on 06/06/2026.
//

import SwiftUI

struct InfoButtonView: View {
    @AppStorage("selectedTab") var selectedTab: Tabs = .info

    let info: Information
    
    @Binding var showCamping: Bool

    var body: some View {
        Button {
            showCamping.toggle()
        } label: {
            Text("On Site Camping")
                .font(.title3)
                .frame(maxWidth: .infinity)
        }

        .buttonStyle(.bordered)

        Button {
            selectedTab = .ticket
        } label: {
            Text(info.displayTicketText)
                .font(.title3)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        Text("Card payments excepted at the festival")
            .font(.caption)
            .padding(.bottom)
    }
}

#Preview {
    InfoButtonView(info: .example, showCamping: .constant(false))
}
