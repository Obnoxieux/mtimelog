//
//  TaskDetail.swift
//  mtimelog
//
//  Created by David Battefeld on 25.06.23.
//

import SwiftUI

struct TaskDetail: View {
    @AppStorage("hoursInWorkingDay") var hoursInWorkingDay = 8
    var task: Task
    
    let listPadding: CGFloat = 7
    
    var body: some View {
        
        List {
            let gaugePercentage = task.calculatePercentageOfWorkingDay(hoursInWorkingDay: hoursInWorkingDay)
            switch task.status {
                
            case .ongoing:
                TaskDetailMainInfo(task: task)
                    .padding(.vertical, listPadding)
                VStack(spacing: 10) {
                    HStack {
                        Text("Started: ") + Text(task.startTime, style: .time).font(.headline)
                        Spacer()
                        Text(task.startTime, style: .timer)
                            .font(.headline)
                    }
                    .padding(.vertical, listPadding)
                    
                   
                    Gauge(value: gaugePercentage) {
                        Text("% of Workday")
                    }
                    .padding(.vertical, listPadding)
                }
                Label(task.status.rawValue, systemImage: "info.square")
                    .foregroundColor(task.status.color)
                    .padding(.vertical, listPadding)
                HStack {
                    Spacer()
                    Button("Finish Task") {
                        //
                    }
                    .buttonStyle(.borderedProminent)
                    Spacer()
                }
                .padding(.vertical, listPadding)
                
            default:
                TaskDetailMainInfo(task: task)
                    .padding(.vertical, listPadding)
                if let endTime = task.endTime {
                    HStack {
                        Image(systemName: "clock")
                            .foregroundColor(.accentColor)
                        Text(task.startTime...endTime)
                    }
                    .padding(.vertical, listPadding)
                    Label(task.getDuration(), systemImage: "hourglass")
                        .padding(.vertical, listPadding)
                    Gauge(value: gaugePercentage) {
                        Text("% of Workday")
                    }
                    .padding(.vertical, listPadding)
                }
                if let comment = task.statusComment {
                    Label(comment, systemImage: task.status == .blocked ? "exclamationmark.bubble" : "bubble.left")
                        .padding(.vertical, listPadding)
                }
                Label(task.status.rawValue, systemImage: "info.square")
                    .foregroundColor(task.status.color)
                    .padding(.vertical, listPadding)
            }
        }
    }
}

struct TaskDetail_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetail(task: Task.sampleData[0])
    }
}
