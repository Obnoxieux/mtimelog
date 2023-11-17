//
//  TaskDetailStatusSection.swift
//  mtimelog
//
//  Created by David Battefeld on 17.11.23.
//

import SwiftUI

struct TaskDetailStatusSection: View {
    var task: Task
    var body: some View {
        if let comment = task.statusComment {
            Label(comment, systemImage: task.status == .blocked ? "exclamationmark.bubble" : "bubble.left")
        }
        Label(task.status.rawValue, systemImage: "info.square")
            .foregroundColor(task.status.color)
    }
}

#Preview {
    TaskDetailStatusSection(task: Task.sampleData[0])
}
