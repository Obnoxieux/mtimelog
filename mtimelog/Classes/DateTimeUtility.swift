//
//  DateTimeUtility.swift
//  mtimelog
//
//  Created by David Battefeld on 10.11.23.
//

import Foundation

class DateTimeUtility {
    static func getFirstAndLastDayOfWeek(calendar: Calendar, date: Date) -> (firstDay: Date, lastDay: Date) {
        let weekday = calendar.component(.weekday, from: date)

        let daysToSubtract = (weekday - calendar.firstWeekday + 7) % 7

        var firstDay = calendar.date(byAdding: .day, value: -daysToSubtract, to: date)!
        firstDay = calendar.startOfDay(for: firstDay)

        var lastDay = calendar.date(byAdding: .day, value: 6, to: firstDay)!
        lastDay = calendar.date(byAdding: .hour, value: 23, to: lastDay)!
        lastDay = calendar.date(byAdding: .second, value: 59, to: lastDay)!

        return (firstDay, lastDay)
    }
}
