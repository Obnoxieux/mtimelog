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
        Label(task.description ?? "No description provided", systemImage: "list.bullet.clipboard")
    }
}

struct TaskDetailMainInfo_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailMainInfo(task: Task.sampleData[0])
    }
}
