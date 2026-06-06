//
//  Information.swift
//  Ashcott
//
//  Created by Nigel Gee on 15/05/2026.
//

import Foundation
import MapKit

nonisolated struct Information: Codable {

    /// A property for the main title
    var title: String

    /// A property for the header image
    var image: String

    /// A property for the start of festival
    ///
    /// - Note: The raw data format is "dd/MM/yyyy
    var startDate: Date

    /// A property for the end date of festival
    ///
    /// - Note: The format is "dd/MM/yyyy
    var endDate: Date

    /// A property for the header text
    var headerText: String

    /// A property for the main body of text
    var bodyText: String

    /// A property for the text on ticket Button
    var ticketText: String

    /// A property for the text on GroupBox for sponsor/volunteer
    var helpTitle: String

    /// A property for the text title on GroupBox for volunteer
    var volunteersTitle: String

    /// A property for the body text for volunteer
    var volunteersText: String

    /// A property for the text title on GroupBox for sponsors
    var sponsorTitle: String

    /// A property for the body text for sponsors
    var sponsorText: String
    
    /// A property that holds ``title`` of the drink item
    ///
    /// - Note: This converts text to display as markdown
    var displayTitle: LocalizedStringResource { "\(title)"}

    /// A property that holds ``headerText`` of the drink item
    ///
    /// - Note: This converts text to display as markdown
    var displayHeaderText: LocalizedStringResource { "\(headerText)"}

    /// A property that holds ``bodyText`` of the drink item
    ///
    /// - Note: This converts text to display as markdown
    var displayBodyText: LocalizedStringResource { "\(bodyText)" }

    /// A property that holds ``ticketText`` of the drink item
    ///
    /// - Note: This converts text to display as markdown
    var displayTicketText: LocalizedStringResource { "\(ticketText)"}

    /// A property that holds ``helpTitle`` of the drink item
    ///
    /// - Note: This converts text to display as markdown
    var displayHelpTitle: LocalizedStringResource { "\(helpTitle)"}

    /// A property that holds ``volunteersText`` of the drink item
    ///
    /// - Note: This converts text to display as markdown
    var displayVolunteersText: LocalizedStringResource { "\(volunteersText)"}

    /// A property that holds ``sponsorText`` of the drink item
    ///
    /// - Note: This converts text to display as markdown
    var displaySponsorText: LocalizedStringResource { "\(sponsorText)"}

    static let example = Information(
        title: "Welcome\n- As seen on TV! -",
        image: "header.png",
        startDate: .now,
        endDate: .now,
        headerText: "The Ashcott Beer Fest is an annual event held in the village of Ashcott in Somerset.  The weekend of fine ales and entertainment is intended for both the beer expert and the family to enjoy.",
        bodyText: "There will be a family fun day on the Saturday and this year the theme is ‘**Down on the Farm**’ - there may even be some real animals to see!\n\nAs always there will be great food, ales, local ciders and wine for all to enjoy. Check out Sarah Beeny’s ‘New Life in the Country’ in series 3 as they did some filming at 2022’s Beer Fest and we are featured in [episode 6](https://www.channel4.com/programmes/sarah-beenys-new-life-in-the-country/on-demand/73499-006)!\n\nPlease be aware **no dogs** are allowed within the beer fest site.\n\n[This year all camping must be booked prior to the event here.](https://docs.google.com/forms/d/e/1FAIpQLSczKZgcVQyzllXyRiDzlN2Y7n29PqDDNf6sczvFDjHjnVLKVg/viewform)",
        ticketText: "Admission prices and Tickets for 2026",
        helpTitle: "**How *YOU* can help…**",
        volunteersTitle: "Volunteers",
        volunteersText: "Ashcott Beer Fest has an amazing band of friendly volunteers who help with different parts of the festival. Please email ashcottbeerfest@gmail.com if you would like to lend a hand.",
        sponsorTitle: "Be our hero! - Sponsor.",
        sponsorText: "Help us by sponsoring a barrel of beer, cider or the sponsor the music! Many of the local firms support us and without this we would be unlikely to make any money for our charities."
    )

    static let imageExample = Information(
        title: "",
        image: "downOnTheFarm.png",
        startDate: .now,
        endDate: .now,
        headerText: "",
        bodyText: "",
        ticketText: "",
        helpTitle: "",
        volunteersTitle: "",
        volunteersText: "",
        sponsorTitle: "",
        sponsorText: ""
    )
}
