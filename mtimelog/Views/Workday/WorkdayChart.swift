//
//  WorkdayChart.swift
//  mtimelog
//
//  Created by David Battefeld on 16.11.23.
//

import SwiftUI
import Charts

struct WorkdayChart: View {
    @AppStorage("hoursInWorkingDay") var hoursInWorkingDay = 8
    
    var workday: Workday
    
    var body: some View {
        Chart {
            ForEach(workday.tasks, id: \.id) { task in
                let duration = task.getDurationAsInterval()
                BarMark (
                    x: .value("Time used", task.getDurationAsInterval() / 3600)
                )
                .foregroundStyle(by: .value("Project", task.projectID))
            }
        }
        .chartXScale(domain: [0, hoursInWorkingDay])
    }
}

#Preview {
    WorkdayChart(workday: Workday.sampleData[0])
}
