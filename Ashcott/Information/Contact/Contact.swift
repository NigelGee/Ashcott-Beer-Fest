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

        /// A property that description of the type of email
        var description: String

        /// A property for the email address
        var email: String

        /// A property of the subject line of email
        var subject: String

        /// A property of the main body of an email if provided
        var emailBody: String?
    }
    
    /// A property of text about ``Contact``
    private var bodyText: String

    /// An array of email elements
    var emails: [Email]
    
    /// A property that holds ``bodyText`` of the ``Contact``
    ///
    /// - Note: This converts text to display as markdown
    var displayBodyText: LocalizedStringResource { "\(bodyText)" }
}
