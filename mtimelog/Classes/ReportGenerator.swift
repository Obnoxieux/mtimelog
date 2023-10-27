//
//  ReportGenerator.swift
//  mtimelog
//
//  Created by David Battefeld on 27.10.23.
//

import Foundation

class ReportGenerator {
    let workday: Workday
    let includeDuration: Bool
    
    init(workday: Workday, includeDuration: Bool) {
        self.workday = workday
        self.includeDuration = includeDuration
    }
    
    func generateReport() -> String {
        var fullReport: String = ""
        
        for task in workday.tasks where task.status != .ongoing {
            let taskReport = reportSingleTask(task: task)
            fullReport.append(taskReport)
            // multiline strings trim whitespace, so add line break manually
            fullReport.append("\n\n")
        }
        return fullReport
    }
    
    private func reportSingleTask(task: Task) -> String {
        return """
Status for Working Day \(workday.date.formatted(date: .numeric, time: .omitted))

\(task.projectID):

- \(task.taskDescription ?? "")

\(includeDuration ? getDurationData(task: task) : "")
Status:
\(task.status)

Comment:
\(task.statusComment ?? "")
_____________________________________________________
"""
    }
    
    private func getDurationData(task: Task) -> String {
        var durationData = """
Time used:
\(task.getDuration()) (\(task.startTime.formatted(date: .omitted, time: .shortened)) - \(task.endTime?.formatted(date: .omitted, time: .shortened) ?? "not yet finished"))
"""
        durationData.append("\n\n")
        return durationData
    }
}
