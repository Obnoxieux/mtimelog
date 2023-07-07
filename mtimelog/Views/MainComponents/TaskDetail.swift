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
            switch task.status {
                
            case .ongoing:
                TaskDetailMainInfo(task: task)
                Divider()
                VStack(spacing: 10) {
                    HStack {
                        Text("Started: ") + Text(task.startTime, style: .time).font(.headline)
                        Spacer()
                        Text(task.startTime, style: .timer)
                            .font(.headline)
                    }
                    
                    Gauge(value: 0.3) {
                        Text("% of Workday")
                    }
                }
                Divider()
                Label(task.status.rawValue, systemImage: "info.square")
                    .foregroundColor(task.status.color)
                Divider()
                HStack {
                    Spacer()
                    Button("Finish Task") {
                        //
                    }
                    .buttonStyle(.borderedProminent)
                    Spacer()
                }
                
            default:
                TaskDetailMainInfo(task: task)
                Divider()
                if let endTime = task.endTime {
                    HStack {
                        Image(systemName: "clock")
                            .foregroundColor(.accentColor)
                        Text(task.startTime...endTime)
                    }
                    Label(task.getDuration(), systemImage: "hourglass")
                    Divider()
                }
                if let comment = task.statusComment {
                    Label(comment, systemImage: task.status == .blocked ? "exclamationmark.bubble" : "bubble.left")
                }
                Label(task.status.rawValue, systemImage: "info.square")
                    .foregroundColor(task.status.color)
            }
        }
    }
}

struct TaskDetail_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetail(task: Task.sampleData[1])
    }
}
