//
//  TicketImageView.swift
//  Ashcott
//
//  Created by Nigel Gee on 07/06/2026.
//

import SwiftUI

struct TicketImageView: View {
    let price: Ticket.Price

    var body: some View {
        if let image = price.image {
            AsyncImage(url: URL(string: "\(Base.url.rawValue)images/\(image)")) { phase in
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
}

#Preview("Light") {
    TicketImageView(price: .example)
}

#Preview("Dark") {
    TicketImageView(price: .example)
        .preferredColorScheme(.dark)
}
