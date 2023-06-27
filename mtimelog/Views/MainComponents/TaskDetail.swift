//
//  TaskDetail.swift
//  mtimelog
//
//  Created by David Battefeld on 25.06.23.
//

import SwiftUI

struct TaskDetail: View {
    var task: Task
    
    var body: some View {
        List {
            Label(task.projectID, systemImage: "tray.full")
                .bold()
                .labelStyle(.titleOnly)
            Label(task.description, systemImage: "list.bullet.clipboard")
            Divider()
            HStack {
                Image(systemName: "clock")
                    .foregroundColor(.accentColor)
                Text(task.startTime...task.endTime)
            }
            Label(task.getDuration(), systemImage: "hourglass")
            Divider()
            Label(task.statusComment, systemImage: task.status == .blocked ? "exclamationmark.bubble" : "bubble.left")
            Label(task.status.rawValue, systemImage: "info.square")
                .foregroundColor(task.status.color)
        }
    }
}

struct TaskDetail_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetail(task: Task.sampleData[0])
    }
}
