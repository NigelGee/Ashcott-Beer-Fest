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
                                    .padding(.bottom)
                            } else {
                                Text("Tickets will be available on-line until \(Text(ticket.cutoffDate.formatted(date: .complete, time: .shortened)).font(.title3).bold()).")
                                    .padding(.bottom)
                            }

                            Text(ticket.descriptionDisplay)
                        }
                        .padding(.horizontal ,10)

                        Divider()

                        TicketPriceView(ticket: ticket)

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
                from: API.baseURL + API.jsonFile.tickets,
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
