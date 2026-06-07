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
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .clipShape(.rect(cornerRadius: 10))
                } else if phase.error != nil {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .clipShape(.rect(cornerRadius: 10))
                } else {
                    ProgressView()
                        .frame(width: 60, height: 60)
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
