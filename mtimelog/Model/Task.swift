//
//  Task.swift
//  mtimelog
//
//  Created by David Battefeld on 25.06.23.
//

import Foundation

struct Task: Hashable, Codable, Identifiable {
    var id = UUID()
    var projectID: String
    var description: String
    var statusComment: String
    var status: TaskStatus
    var startTime: Date
    var endTime: Date
    
    func getDuration() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute]
        formatter.unitsStyle = .short
            
        let duration = endTime.timeIntervalSince(startTime)
        let formattedDuration = formatter.string(from: duration)!
        
        return formattedDuration
    }
}

extension Task {
    static let sampleData = [
        Task(projectID: "ABC-010-4857", description: "[35837] Do this complex task => Waiting for feedback and do a whole lot, mostly producing text to fill this little box and be realistic", statusComment: "Waiting for feedback", status: .inProgress, startTime: Date(), endTime: Date().addingTimeInterval(10000)),
        Task(projectID: "54321", description: "Review code changes", statusComment: "Pending review", status: .inProgress, startTime: Date(), endTime: Date()),
        Task(projectID: "98765", description: "Test new feature", statusComment: "Test cases passed", status: .completed, startTime: Date(), endTime: Date()),
        Task(projectID: "24680", description: "Debug issue #123", statusComment: "Investigating the root cause", status: .inProgress, startTime: Date(), endTime: Date()),
        Task(projectID: "13579", description: "Design UI mockups", statusComment: "Pending design approval", status: .blocked, startTime: Date(), endTime: Date())
    ]
}
