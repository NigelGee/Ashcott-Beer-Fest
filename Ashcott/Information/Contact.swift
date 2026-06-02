//
//  Contacts.swift
//  Ashcott
//
//  Created by Nigel Gee on 16/05/2026.
//

import Foundation

nonisolated struct Contact: Codable {
    struct Email: Codable, Identifiable {
        var id: UUID { UUID() }
        var description: String
        var email: String
        var subject: String
        var emailBody: String?
    }

    private var bodyText: String
    var emails: [Email]

    var displayBodyText: LocalizedStringResource { "\(bodyText)" }
}
