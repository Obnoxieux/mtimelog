//
//  Workday.swift
//  mtimelog
//
//  Created by David Battefeld on 26.06.23.
//

import Foundation

struct Workday: Hashable, Codable, Identifiable {
    var id = UUID()
    var date: Date
    var tasks: [Task]
}

extension Workday {
    static let sampleData = [
        Workday(date: Date(), tasks: []),
        Workday(date: Date(), tasks: []),
        Workday(date: Date(), tasks: []),
        Workday(date: Date(), tasks: []),
        Workday(date: Date(), tasks: []),
    ]
}
