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
        let gaugePercentage = task.calculatePercentageOfWorkingDay(hoursInWorkingDay: hoursInWorkingDay)
        
        switch task.status {
        case .ongoing:
            VStack(spacing: 10) {
                HStack {
                    Text("Started: ") + Text(task.startTime, style: .time).font(.headline)
                    Spacer()
                    Text(task.startTime, style: .timer)
                        .font(.headline)
                }
                Gauge(value: gaugePercentage) {
                    Text("% of Workday")
                }
            }
        default:
            if let endTime = task.endTime {
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(.accentColor)
                    Text(task.startTime...endTime)
                }
                Label(task.getDuration(), systemImage: "hourglass")
                Gauge(value: gaugePercentage) {
                    Text("% of Workday")
                }
            }
        }
        
    }
}

#Preview {
    TaskDetailTimeSection(task: Task.sampleData[0])
}
