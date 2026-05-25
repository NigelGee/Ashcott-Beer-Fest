//
//  DateFormatter-Helper.swift
//  Ashcott
//
//  Created by Nigel Gee on 16/05/2026.
//

import Foundation

extension DateFormatter {
    static var date: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }

    static var dateTime: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter
    }

    static var time: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }
}
