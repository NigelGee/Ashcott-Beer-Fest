//
//  TicketImageView.swift
//  Ashcott
//
//  Created by Nigel Gee on 07/06/2026.
//

import SwiftUI

struct TicketImageView: View {
    let image: String

    var body: some View {
        AsyncImage(url: URL(string: API.baseURL + API.image + image)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 60, height: 60)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .clipShape(.rect(cornerRadius: 10))
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .clipShape(.rect(cornerRadius: 10))
                    .foregroundStyle(.secondary)
            @unknown default:
                fatalError("A new image phase")
            }
        }
    }
}

#Preview("Light") {
    TicketImageView(image: "farmerBully.png")
}

#Preview("Dark") {
    TicketImageView(image: "farmerBully.png")
        .preferredColorScheme(.dark)
}
