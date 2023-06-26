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
        VStack(alignment: .leading, spacing: 5) {
            Label(task.projectID, systemImage: "tray.full")
                .font(.callout)
                .bold()
                .labelStyle(.titleOnly)
            Label(task.description, systemImage: "list.bullet.clipboard")
            Divider()
                .padding(.trailing)
            HStack {
                Image(systemName: "clock")
                    .foregroundColor(.blue)
                Text(task.startTime...task.endTime)
            }
            .padding(.leading, 2)
            Label(task.getDuration(), systemImage: "hourglass")
            Divider()
                .padding(.trailing)
            Label(task.statusComment, systemImage: task.status == .blocked ? "exclamationmark.bubble" : "bubble.left")
            Label(task.status.rawValue, systemImage: "info.square")
                .foregroundColor(task.status.color)
        }
        .accentColor(.blue)
        .font(.caption)
        .padding(5)
    }
}

struct TaskDetail_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetail(task: Task.sampleData[0])
    }
}
