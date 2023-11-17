//
//  TaskDetailTimeSection.swift
//  mtimelog
//
//  Created by David Battefeld on 17.11.23.
//

import SwiftUI

struct TaskDetailTimeSection: View {
    @AppStorage("hoursInWorkingDay") var hoursInWorkingDay = 8
    
    var task: Task
    
    var body: some View {
        VStack {
            switch task.status {
            case .ongoing:
                HStack {
                    Text("Started: ") + Text(task.startTime, style: .time).font(.headline)
                    Spacer()
                    Text(task.startTime, style: .timer)
                        .font(.headline)
                }
            default:
                if let endTime = task.endTime {
                    HStack {
                        HStack {
                            Image(systemName: "clock")
                            Text(task.startTime...endTime)
                        }
                        Spacer()
                        Label(task.getDuration(), systemImage: "hourglass")
                    }
                }
            }
        }
        .padding(28)
        .modifier(TaskDetailCardBackground())
    }
}

#Preview {
    TaskDetailTimeSection(task: Task.sampleData[0])
}
