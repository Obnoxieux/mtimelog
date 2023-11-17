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
        Label(task.projectID, systemImage: "tray.full")
            .bold()
            .labelStyle(.titleOnly)
            .textSelection(.enabled)
        HStack {
            Label(task.taskDescription ?? "No description provided", systemImage: "list.bullet.clipboard")
                .textSelection(.enabled)
            Spacer()
            Button("Copy") {
                let pasteboard = NSPasteboard.general
                pasteboard.declareTypes([.string], owner: nil)
                pasteboard.setString(task.copyTaskTextToClipboard(includeProjectID: false), forType: .string)
            }
        }
    }
}

#Preview {
    TaskDetailMainInfo(task: Task.sampleData[0])
}
