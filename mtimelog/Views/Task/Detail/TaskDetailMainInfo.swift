//
//  TaskDetailMainInfo.swift
//  mtimelog
//
//  Created by David Battefeld on 07.07.23.
//

import SwiftUI

struct TaskDetailMainInfo: View {
    var task: Task
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Label(task.projectID, systemImage: "tray.full")
                    .bold()
                // .labelStyle(.titleOnly)
                Label(task.taskDescription ?? "No description provided", systemImage: "list.bullet.clipboard")
            }
            Spacer()
        }
        .textSelection(.enabled)
        .padding()
        .modifier(TaskDetailCardBackground())
    }
}

#Preview {
    TaskDetailMainInfo(task: Task.sampleData[0])
}
