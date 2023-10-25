//
//  TaskItem.swift
//  mtimelog
//
//  Created by David Battefeld on 26.06.23.
//

import SwiftUI

struct TaskItem: View {
    var task: Task
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack() {
                Label(task.projectID, systemImage: "tray.full")
                    .font(.callout)
                    .bold()
                    .labelStyle(.titleOnly)
                Spacer()
                Label(task.getDuration(), systemImage: "hourglass")
            }
            Label(task.taskDescription ?? "No description provided", systemImage: "list.bullet.clipboard")
                .lineLimit(2)
            Label(task.status.rawValue, systemImage: "info.square")
                .foregroundColor(task.status.color)
        }
        .font(.callout)
        .padding(5)
    }
}

struct TaskItem_Previews: PreviewProvider {
    static var task = Task.sampleData[0]
    static var previews: some View {
        TaskItem(task: task)
            .previewLayout(.fixed(width: 1500, height: 600))
    }
}
