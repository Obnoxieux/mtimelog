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
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                if let comment = task.statusComment {
                    if !comment.isEmpty {
                        Label(comment, systemImage: task.status == .blocked ? "exclamationmark.bubble" : "bubble.left")
                    }
                }
                Label(task.status.rawValue, systemImage: "info.square")
                    .foregroundColor(task.status.color)
            }
            Spacer()
        }
        .padding()
        .modifier(TaskDetailCardBackground())
    }
}

#Preview {
    TaskDetailStatusSection(task: Task.sampleData[0])
}
