//
//  WeeklyWorkdayChartList.swift
//  mtimelog
//
//  Created by David Battefeld on 16.11.23.
//

import SwiftUI
import SwiftData

struct WeeklyWorkdayChartList: View {
    @Query var workdays: [Workday]
    
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
            Section(header: Text("Statistical data for all working days in the week")) {
                ForEach(workdays, id: \.id) {
                    WorkdayChart(workday: $0)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    WeeklyWorkdayChartList(startDate: .now, endDate: .now)
}
