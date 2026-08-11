//
//  TicketPriceView.swift
//  Ashcott
//
//  Created by Nigel Gee on 08/06/2026.
//

import SwiftUI

struct TicketPriceView: View {
    let ticket: Ticket

    var body: some View {
        ForEach(ticket.prices) { price in
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            if let image = price.image, let url = URL(string: API.baseURL + API.image + image) {
                                CacheAsyncImage(for: image, url: url)
                                    .clipShape(.rect(cornerRadius: 10))
                                    .frame(width: 60, height: 60)
                            }

                            Text(price.type)
                                .font(.title3)
                                .bold()
                        }

                        Text(price.displayDescription)
                    }

                    if let url = price.url {
                        Spacer()
                        Link(destination: url) {
                            if price.amount == 0 {
                                Text("Free")
                                    .font(.system(size: 15))
                                    .frame(width: 55)
                            } else {
                                Text(price.amount, format: .currency(code: "GBP"))
                                    .font(.system(size: 15))
                                    .frame(width: 55)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(ticket.cutoffDate < .now)
                    }
                }

                Divider()
            }
            .padding(.horizontal, 9)
        }
    }
}

#Preview("Light") {
    TicketPriceView(ticket: .example)
        .padding()
        .environment(ImageCache())
}

#Preview("Dark") {
    TicketPriceView(ticket: .example)
        .padding()
        .preferredColorScheme(.dark)
        .environment(ImageCache())
}
