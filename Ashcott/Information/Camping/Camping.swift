//
//  Camping.swift
//  Ashcott
//
//  Created by Nigel Gee on 16/05/2026.
//

import Foundation

nonisolated struct Camping: Codable {
    /// A property that is the header image for ``CampView``
    var image: String

    /// A property that is the first text of ``CampView``
    private var welcomeText: String

    /// A property that is the main text of ``CampView``
    private var bodyText: String
    
    /// A property that holds ``welcomeText`` of the ``Camping``
    ///
    /// - Note: This converts text to display as markdown
    var displayWelcomeText: LocalizedStringResource { "\(welcomeText)" }

    /// A property that holds ``bodyText`` of the ``Camping``
    ///
    /// - Note: This converts text to display as markdown
    var displayBodyText: LocalizedStringResource { "\(bodyText)"}

    static let example = Camping(
        image: "campSite.jpg",
        welcomeText: "Camping is for festival-goers only and is available right next door to the Beer Fest site! The Beer Fest and camping are situated in the Ashcott Playing fields.",
        bodyText: "Access to the camping will be via the Beer Fest entry point. The good news is that the cost of camping will be included in the Beer Fest entry price!\n[Please register your intention to camp here. This must be done before the event.](https://docs.google.com/forms/d/e/1FAIpQLSczKZgcVQyzllXyRiDzlN2Y7n29PqDDNf6sczvFDjHjnVLKVg/viewform)\n\nIf you are camping, please bear in mind that we are NOT a campsite! Don’t expect showers (unless it rains!) Or well-tiled toilet blocks!  Although you will still have access to the porta-loos.  Nor can we guarantee the security of your belongings.  You basically get a corner of the field - so if you go to bed early, you’ll still hear the music.\n\n**Please note:** dogs are no longer allowed into the Beer Fest site but are welcome in the camp site area but please clean up after them so bring plenty of poo-bags! Also, no stereos or amplified music will be allowed in the camping area and no movement of cars will be allowed after 10pm at night and before 7am.\n\nBut don’t let this put you off.  Obviously, spending the night in a tent ensures you can enjoy your evening without having to find a way home at midnight!\n\n[Read the PDF version of the full camping rules here.](https://www.ashcottbeerfest.org/ABF%20Camping%20rules.pdf)\n\n**Please note: Children under 18-year-old MUST be accompanied by a parent or responsible adult OVER the age of 25.**\n\nPlease look after our beautiful facility and leave it litter-free. Email for any queries - ashcottbeerfestcamping@gmail.com"
    )
}
