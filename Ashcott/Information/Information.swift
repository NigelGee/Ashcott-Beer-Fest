//
//  Information.swift
//  Ashcott
//
//  Created by Nigel Gee on 15/05/2026.
//

import Foundation
import MapKit

nonisolated struct Information: Codable {
    var title: String
    var image: String
    var startDate: Date
    var endDate: Date
    var headerText: String
    var bodyText: String
    var ticketText: String
    var helpTitle: String
    var volunteersTitle: String
    var volunteersText: String
    var sponsorTitle: String
    var sponsorText: String

    var titleDisplay: LocalizedStringResource { "\(title)"}
    var headerTextDisplay: LocalizedStringResource { "\(headerText)"}
    var bodyTextDisplay: LocalizedStringResource { "\(bodyText)" }
    var ticketTextDisplay: LocalizedStringResource { "\(ticketText)"}
    var helpTitleDisplay: LocalizedStringResource { "\(helpTitle)"}
    var volunteersTextDisplay: LocalizedStringResource { "\(volunteersText)"}
    var sponsorTextDisplay: LocalizedStringResource { "\(sponsorText)"}

    static let example = Information(
        title: "Welcome\n- As seen on TV! -",
        image: "header",
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
}
