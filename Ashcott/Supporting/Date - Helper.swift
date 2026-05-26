//
//  Date - Helper.swift
//  Ashcott
//
//  Created by Nigel Gee on 26/05/2026.
//

import Foundation

extension Date {
    /// Returns a date by add a number of a period to given date.
    /// - Parameter year: A number to advance the date by a years.
    /// - Parameter month: A number to advance the date by a months.
    /// - Parameter day: A number to advance the date by a daya.
    /// - Parameter hour: A number to advance the date by a hours.
    /// - Parameter minute: A number to advance the date by a minutes.
    /// - Returns: A `Date` with  number of type added.
    ///
    /// ```swift
    /// let fiveDayFromToday = Date.now.add(day: 5)
    /// let oneMonthFromToday = Date.now.add(month: 1)
    /// let oneYearFromToday = Date.now.add(year: 1)
    /// ```
    /// - Tip: By using minus number will return a date before given date.
    public func add(year: Int = 0, month: Int = 0, day: Int = 0, hour: Int = 0, minute: Int = 0) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        return Calendar.current.date(byAdding: dateComponents, to: self) ?? self
    }
}
