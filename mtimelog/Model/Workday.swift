//
//  Workday.swift
//  mtimelog
//
//  Created by David Battefeld on 26.06.23.
//

import Foundation
import SwiftData

@Model
final class Workday {
    var id = UUID()
    var date: Date
    @Relationship(deleteRule: .cascade, inverse: \Task.workday)
    var tasks: [Task] = []
    
    init(id: UUID = UUID(), date: Date, tasks: [Task] = []) {
        self.id = id
        self.date = date
        self.tasks = tasks
    }
    
    func addTask(task: Task) {
        tasks.append(task)
    }
}

extension Workday {
    static let sampleData = [
        Workday(date: Date(), tasks: Task.sampleData),
        Workday(date: Date(), tasks: []),
        Workday(date: Date(), tasks: []),
        Workday(date: Date(), tasks: []),
        Workday(date: Date(), tasks: []),
    ]
}
