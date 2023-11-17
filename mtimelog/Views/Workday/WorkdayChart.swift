//
//  WorkdayChart.swift
//  mtimelog
//
//  Created by David Battefeld on 16.11.23.
//

import SwiftUI
import Charts

struct WorkdayChart: View {
    @Binding var maximumValue: Int
    
    var tasks: [Task]
    
    var body: some View {
        Chart {
            ForEach(tasks, id: \.id) { task in
                BarMark (
                    x: .value("Time used", task.getDurationAsInterval() / 3600)
                )
                .foregroundStyle(by: .value("Project", task.projectID))
            }
        }
        .chartXScale(domain: [0, maximumValue])
    }
}

#Preview {
    WorkdayChart(maximumValue: .constant(8), tasks: Task.sampleData)
}
