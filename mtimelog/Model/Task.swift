//
//  Task.swift
//  mtimelog
//
//  Created by David Battefeld on 25.06.23.
//

import Foundation
import SwiftData

@Model
final class Task: Codable {
    enum CodingKeys: CodingKey {
        case projectID, taskDescription, statusComment, status, startTime, endTime, workday
    }
    
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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        projectID = try container.decode(String.self, forKey: .projectID)
        taskDescription = try container.decode(String.self, forKey: .taskDescription)
        statusComment = try container.decode(String.self, forKey: .statusComment)
        status = try container.decode(TaskStatus.self, forKey: .status)
        startTime = try container.decode(Date.self, forKey: .startTime)
        endTime = try container.decode(Date.self, forKey: .endTime)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(projectID, forKey: .projectID)
        try container.encode(taskDescription, forKey: .taskDescription)
        try container.encode(status, forKey: .status)
        try container.encode(statusComment, forKey: .statusComment)
        try container.encode(startTime, forKey: .startTime)
        try container.encode(endTime, forKey: .endTime)
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
