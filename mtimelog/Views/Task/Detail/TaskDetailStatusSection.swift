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
        VStack(alignment: .leading, spacing: 10) {
            if let comment = task.statusComment {
                if !comment.isEmpty {
                    Label {
                        Text(comment)
                    } icon: {
                        Image(
                            systemName: task.status == .blocked
                                ? "exclamationmark.bubble" : "bubble.left"
                        )
                        .foregroundStyle(.indigo)
                    }
                }
            }
            Label(task.status.rawValue, systemImage: "info.square")
                .foregroundStyle(task.status.color)
        }
    }
}

#Preview {
    TaskDetailStatusSection(task: Task.sampleData[0])
}
