//
//  ContactView.swift
//  Ashcott
//
//  Created by Nigel Gee on 14/05/2026.
//

import AFMessageUI
import SwiftUI

struct ContactView: View {
    @State private var contact: Contact?
    @State private var loadingError = false

    @State private var showMail = false
    @State private var email = ""
    @State private var subject = ""
    @State private var emailBody: String?
    
    var body: some View {
        VStack {
            if let contact {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text(contact.bodyTextDisplay)
                            .padding(.bottom)
                        ForEach(contact.emails) { email in
                            Button {
                                self.email = email.email
                                self.subject = email.subject
                                self.emailBody = email.emailBody
                                showMail.toggle()
                            } label: {
                                VStack {
                                    Text(email.description)
                                    Text(email.email)
                                }
                                .foregroundStyle(.black)
                                .padding(.vertical, 5)
                                .frame(maxWidth: .infinity)
                                .background(.mint)
                                .clipShape(.capsule)
                            }
                            .buttonStyle(.plain)
                        }

                        Divider()
                            .padding(.vertical)

                        if let url = URL(string: "https://www.ashcottbeerfest.org/index.html") {
                            HStack {
                                Image("webIcon")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .clipShape(.rect(cornerRadius: 10))
                                Link("www.ashcottbeerfest.org", destination: url)
                            }
                        }

                        if let url = URL(string: "https://www.facebook.com/ashcottbeerfest/") {
                            HStack {
                                Image("facebookIcon")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .clipShape(.rect(cornerRadius: 10))
                                Link("Ascott Beer Fest", destination: url)
                            }
                        }

                        if let url = URL(string: "https://www.instagram.com/ashcottbeerfest?igsh=ZXVsZndvZjd5OHJl") {
                            HStack {
                                Image("instagram")
                                    .resizable()
                                    .frame(width: 65, height: 65)
                                Link("@ashcottbeerfest", destination: url)
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .scrollBounceBehavior(.basedOnSize)
            } else {
                LoadingView()
            }
        }
        .padding()
        .navigationTitle("Contacts")
        .navigationBarTitleDisplayMode(.inline)
        .task { await fetch() }
        .mailSheet(
            isPresented: $showMail,
            toRecipients: email,
            subject: subject,
            body: emailBody
        )
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
            async let item = try await URLSession.shared.decode(Contact.self, from: "\(Base.url.rawValue)Contact.json")
            contact = try await item
        } catch {
            loadingError.toggle()
        }
    }
}

#Preview("Light") {
    NavigationStack {
        ContactView()
    }
}

#Preview("Dark") {
    NavigationStack {
        ContactView()
            .preferredColorScheme(.dark)
    }
}
