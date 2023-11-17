//
//  WeeklyAggregatedChart.swift
//  mtimelog
//
//  Created by David Battefeld on 17.11.23.
//

import SwiftUI
import SwiftData

struct WeeklyAggregatedChart: View {
    @AppStorage("hoursInWorkingDay") var hoursInWorkingDay = 8
    @Query var workdays: [Workday]
    
    @State var totalWeeklyHours = 0
    @State var totalTasks: [Task] = []
    
    init(
        startDate: Date,
        endDate: Date
    ) {
        let calendar = Calendar.autoupdatingCurrent
        let start = calendar.startOfDay(for: startDate)
        
        let predicate = #Predicate<Workday> { workday in
            workday.date >= start && workday.date <= endDate
        }
        _workdays = Query(filter: predicate, sort: \Workday.date, animation: .easeInOut)
    }
    
    var body: some View {
        List {
            Section(header: Text("Aggregated statistical data for the whole week")) {
                WorkdayChart(maximumValue: $totalWeeklyHours, tasks: totalTasks)
            }
        }
        .task {
            totalWeeklyHours = workdays.count * hoursInWorkingDay
            for workday in workdays {
                totalTasks.append(contentsOf: workday.tasks)
            }
        }
    }
}

#Preview {
    WeeklyAggregatedChart(startDate: .now, endDate: .now)
}
