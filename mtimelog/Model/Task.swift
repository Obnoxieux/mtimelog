//
//  Task.swift
//  mtimelog
//
//  Created by David Battefeld on 25.06.23.
//

import Foundation
import SwiftData

@Model
final class Task {
    @Attribute(.unique) var id = UUID()
    var projectID: String
    var taskDescription: String?
    var statusComment: String?
    var status: TaskStatus
    var startTime: Date
    var endTime: Date?
    var workday: Workday?
    
    init(id: UUID = UUID(), projectID: String, taskDescription: String? = nil, statusComment: String? = nil, status: TaskStatus, startTime: Date, endTime: Date? = nil, workday: Workday? = nil) {
        self.id = id
        self.projectID = projectID
        self.taskDescription = taskDescription
        self.statusComment = statusComment
        self.status = status
        self.startTime = startTime
        self.endTime = endTime
        self.workday = workday
    }
    
    func getDuration() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute]
        formatter.unitsStyle = .short
            
        guard let duration = endTime?.timeIntervalSince(startTime) else { return "TBD" }
        return formatter.string(from: duration)!
    }
    
    func calculatePercentageOfWorkingDay(hoursInWorkingDay: Int) -> Double {
        let endTime = endTime ?? Date.now
        let usedTime = endTime.timeIntervalSince(startTime)
        let maxTime = Double(hoursInWorkingDay) * 3600
        
        if usedTime > maxTime {
            return 1.0
        } else {
            return usedTime / maxTime
        }
    }
    
    func update(projectID: String, taskDescription: String? = nil, statusComment: String? = nil, status: TaskStatus, startTime: Date? = nil, endTime: Date? = nil) {
        self.projectID = projectID
        self.taskDescription = taskDescription
        self.statusComment = statusComment
        self.status = status
        self.startTime = startTime ?? self.startTime
        self.endTime = endTime
    }
}

extension Task {
    static let sampleData = [
        Task(projectID: "ABC-010-4857", taskDescription: "[35837] Do this complex task => Waiting for feedback and do a whole lot, mostly producing text to fill this little box and be realistic", statusComment: "Waiting for feedback", status: .inProgress, startTime: Date(), endTime: Date().addingTimeInterval(1000)),
        Task(projectID: "ABC-010-4857", taskDescription: "[35837] Do this complex task => Waiting for feedback and do a whole lot, mostly producing text to fill this little box and be realistic", statusComment: "Waiting for feedback", status: .ongoing, startTime: Date(), endTime: Date().addingTimeInterval(10000)),
        Task(projectID: "54321", taskDescription: "Review code changes", statusComment: "Pending review", status: .inProgress, startTime: Date(), endTime: Date()),
        Task(projectID: "98765", taskDescription: "Test new feature", statusComment: "Test cases passed", status: .completed, startTime: Date(), endTime: Date()),
        Task(projectID: "24680", taskDescription: "Debug issue #123", statusComment: "Investigating the root cause", status: .inProgress, startTime: Date(), endTime: Date()),
        Task(projectID: "13579", taskDescription: "Design UI mockups", statusComment: "Pending design approval", status: .blocked, startTime: Date(), endTime: Date())
    ]
}
