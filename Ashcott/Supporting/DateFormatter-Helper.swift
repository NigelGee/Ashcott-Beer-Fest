//
//  DateFormatter-Helper.swift
//  Ashcott
//
//  Created by Nigel Gee on 16/05/2026.
//

import Foundation

extension DateFormatter {

    /// A formatter that for "dd/MM/yyyy"
    static var date: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }
    
    /// A formatter that for "dd/MM/yyyy HH;mm"
    static var dateTime: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter
    }
    
    /// A formatter that for "HH:mm"
    static var time: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }
}
