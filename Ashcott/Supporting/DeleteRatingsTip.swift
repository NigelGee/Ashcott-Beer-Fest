//
//  DeleteRatingsTip.swift
//  Ashcott
//
//  Created by Nigel Gee on 31/05/2026.
//

import Foundation
import TipKit

struct DeleteRatingsTip: Tip {
    var options: [TipOption] {
        [
            Tips.MaxDisplayCount(1)
        ]
    }

    var title: Text {
        Text("Delete Ratings…")
            .font(.headline)
            .foregroundStyle(.red)
    }

    var message: Text? {
        Text("Long press to delete the rating.")
    }

    var image: Image? {
        Image(systemName: "trash")
    }
}
