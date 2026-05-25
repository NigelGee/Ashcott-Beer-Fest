//
//  String-Helper.swift
//  Ashcott
//
//  Created by Nigel Gee on 19/05/2026.
//

import Foundation

extension String {
    var formatted: String {
        self.replacingOccurrences(of: " ", with: "")
    }

    func deletingPrefix(_ prefix: String) -> String {
            guard self.hasPrefix(prefix) else { return self }
            return String(self.dropFirst(prefix.count))
    }
}
