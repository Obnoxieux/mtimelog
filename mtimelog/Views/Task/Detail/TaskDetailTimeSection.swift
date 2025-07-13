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
        switch task.status {
        case .ongoing:
            Label {
                Text("Started: ")
                    + Text(task.startTime, style: .time).font(.headline)
            } icon: {
                clockImage
            }

            Label {
                Text(task.startTime, style: .timer)
                    .font(.headline)
            } icon: {
                hourGlassImage
            }
        default:
            if let endTime = task.endTime {
                Label {
                    Text(task.startTime...endTime)
                } icon: {
                    clockImage
                }
                
                Label {
                    Text(task.getDuration())
                } icon: {
                    hourGlassImage
                }
            }
        }
    }

    private var clockImage: some View {
        Image(systemName: "clock")
            .foregroundStyle(.indigo)
            .padding(.leading, 2)
    }

    private var hourGlassImage: some View {
        Image(systemName: "hourglass")
            .foregroundStyle(.indigo)
            .padding(.leading, 4)
    }
}

#Preview {
    TaskDetailTimeSection(task: Task.sampleData[0])
}
