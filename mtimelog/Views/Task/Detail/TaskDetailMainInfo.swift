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
        Label {
            Text(task.projectID)
        } icon: {
            Image(systemName: "tray.full")
                .foregroundStyle(.indigo)
        }
        .bold()
        .textSelection(.enabled)

        Label {
            Text(task.taskDescription ?? "No description provided")
        } icon: {
            Image(systemName: "list.bullet.clipboard")
                .foregroundStyle(.indigo)
        }
        .padding(.leading, 2)
        .padding(.top, 2)
        .textSelection(.enabled)
    }
}

#Preview {
    TaskDetailMainInfo(task: Task.sampleData[0])
}
