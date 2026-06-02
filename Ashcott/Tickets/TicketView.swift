//
//  TicketView.swift
//  Ashcott
//
//  Created by Nigel Gee on 13/05/2026.
//

import SwiftUI

struct TicketView: View {
    @State private var ticket: Ticket?
    @State private var loadingError = false

    var body: some View {
        NavigationStack {
            Group {
                if let ticket {
                    ScrollView {
                        VStack(alignment: .leading) {
                            if ticket.cutoffDate < .now {
                                Text(ticket.closedText)
                                    .foregroundStyle(.red)
                                    .bold()
                                    .padding()
                            } else {
                                Text("Tickets will be available on-line until \(Text(ticket.cutoffDate.formatted(date: .complete, time: .shortened)).bold()).")
                                    .padding([.horizontal, .bottom])
                            }

                            Text(ticket.descriptionDisplay)
                                .padding(.horizontal)
                        }


                        Divider()
                        ForEach(ticket.prices) { price in
                            VStack(alignment: .leading) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        HStack {
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
                                            Text(price.type)
                                                .font(.title2)
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
                            .padding(.horizontal)
                        }

                    }
                } else {
                   LoadingView()
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            .navigationTitle("Ticket Prices")
        }
        .task { await fetch() }
        .sheet(isPresented: $loadingError) {
            ErrorLoadingView {
                await fetch()
            }
        }
    }

    /// Call for get JSON data from URL
    /// requires `@State private var name = [Decodable]()`
    /// and `.task { await fetch() }`
    func fetch() async {
        do  {
            async let item = try await URLSession.shared.decode(
                Ticket.self,
                from: "\(Base.url.rawValue)Tickets.json",
                dateDecodingStrategy: .formatted(.dateTime)
            )
            ticket = try await item
        } catch {
            loadingError.toggle()
        }
    }
}

#Preview("Light") {
    TicketView()
}

#Preview("Dark") {
    TicketView()
        .preferredColorScheme(.dark)
}
