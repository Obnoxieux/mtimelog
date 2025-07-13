//
//  Workday.swift
//  mtimelog
//
//  Created by David Battefeld on 26.06.23.
//

import Foundation
import SwiftData

@Model
final class Workday: Codable {
    enum CodingKeys: CodingKey {
        case date, tasks
    }
    
    @Attribute(.unique) var id = UUID()
    var date: Date
    @Relationship(deleteRule: .cascade, inverse: \Task.workday)
    var tasks: [Task] = []
    
    init(id: UUID = UUID(), date: Date, tasks: [Task] = []) {
        self.id = id
        self.date = date
        self.tasks = tasks
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(Date.self, forKey: .date)
        tasks = try container.decode([Task].self, forKey: .tasks)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(date, forKey: .date)
        try container.encode(tasks, forKey: .tasks)
    }
    
    func addTask(task: Task) {
        tasks.append(task)
    }
    
    func generateReport(includeDuration: Bool) -> String {
        let reportGenerator = ReportGenerator(workday: self, includeDuration: includeDuration)
        return reportGenerator.generateReport()
    }
    
    func sendReportEmail(includeDuration: Bool) {
        let reportGenerator = ReportGenerator(workday: self, includeDuration: includeDuration)
        reportGenerator.sendReportEmailDirectly()
    }
    
    func generateExportText() -> String {
        var taskTexts = ""
        for task in tasks {
            taskTexts.append(task.generateExportText())
            taskTexts.append("\n")
        }
        
        return """
BEGIN WORKING DAY
\(date.ISO8601Format())
\(taskTexts)
END WORKING DAY
"""
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
