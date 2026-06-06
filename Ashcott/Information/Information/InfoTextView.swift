//
//  InfoTextView.swift
//  Ashcott
//
//  Created by Nigel Gee on 06/06/2026.
//

import SwiftUI

struct InfoTextView: View {
    let info: Information

    var body: some View {
        Text(info.displayTitle)
            .font(.largeTitle)
            .multilineTextAlignment(.center)

        HStack {
            Text(info.startDate, style: .date)
            Text("to")
            Text(info.endDate, style: .date)
        }
        .purpleCapsuleModifier

        Text(info.displayHeaderText)
            .padding(.bottom)
            .font(.title3)
            .foregroundStyle(.mint)

        Text(info.displayBodyText)
            .padding(.bottom)
    }
}

#Preview {
    InfoTextView(info: .example)
}
