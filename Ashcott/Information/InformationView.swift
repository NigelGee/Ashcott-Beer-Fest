//
//  Information.swift
//  Ashcott
//
//  Created by Nigel Gee on 13/05/2026.
//

import SwiftUI

struct InformationView: View {
    @AppStorage("selectedTab") var selectedTab: Tabs = .info

    @State private var info: Information?
    @State private var loadingError = false

    @State var showContacts = false
    @State var showMap = false
    @State var showCamping = false

    var body: some View {
        NavigationStack {
            Group {
                if let info {
                    ScrollView {
                        AsyncImage(url: URL(string: "\(Base.url.rawValue)images/\(info.image)")) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                            } else if phase.error != nil {
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .clipShape(.rect(cornerRadius: 10))
                            } else {
                                ProgressView()
                                    .frame(width: 100, height: 100)
                            }
                        }

                        VStack {
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
                        .padding()
                    }
                    .scrollBounceBehavior(.basedOnSize)
                } else {
                    LoadingView()
                }
            }
            .navigationTitle("Ashcott Beer Fest")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Contact", systemImage: "person.fill") {
                        showContacts.toggle()
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button("Map", systemImage: "map") {
                        showMap.toggle()
                    }
                }

                ToolbarItem(placement: .topBarLeading) {
                    Button("Camping" , systemImage: "tent.2") {
                        showCamping.toggle()
                    }
                }
            }
            .navigationDestination(isPresented: $showContacts, destination: ContactView.init)
            .navigationDestination(isPresented: $showMap, destination: LocationView.init)
            .navigationDestination(isPresented: $showCamping, destination: CampView.init)
            .sheet(isPresented: $loadingError) {
                ErrorLoadingView {
                    await fetch()
                }
            }
        }
        .task { await fetch() }
    }

    /// Call for get JSON data from URL
    /// requires `@State private var name = [Decodable]()`
    /// and `.task { await fetch() }`
    func fetch() async {
        do  {
            async let item = try await URLSession.shared.decode(Information.self, from: "\(Base.url.rawValue)Information.json", dateDecodingStrategy: .formatted(.date))
            info = try await item
        } catch {
            print("Failed to fetch data!")
        }
    }
}

#Preview("Light") {
    InformationView()
}

#Preview("Dark") {
    InformationView()
        .preferredColorScheme(.dark)
}
