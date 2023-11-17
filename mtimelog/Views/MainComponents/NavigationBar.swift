//
//  NavigationBar.swift
//  mtimelog
//
//  Created by David Battefeld on 25.06.23.
//

import SwiftUI
import SwiftData

struct NavigationBar: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.calendar) var calendar
    
    @State var selectedDate: Date = .now
    @State var startDate: Date = .now
    @State var endDate: Date = .now
    
    var body: some View {
        List {
            Section(
                header: Text("Select the calendar week")
            ) {
                DatePicker("Week", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .labelsHidden()
                Text("The exact day selected does not matter.")
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                    .font(.caption)
                Divider()
                WorkdayCollection(startDate: startDate, endDate: endDate)
            }
            Spacer()
            Section(header: Text("Stats")) {
                NavigationLink(destination: WeeklyWorkdayChartList(startDate: startDate, endDate: endDate), label: {
                    Text("Individual Days")
                })
                NavigationLink(destination: WeeklyAggregatedChart(startDate: startDate, endDate: endDate), label: {
                    Text("Aggregated")
                })
            }
        }
        .listStyle(.sidebar)
        .navigationTitle("Workdays")
        
        .onAppear {
            getDateInfo(date: selectedDate)
        }
        
        .onChange(of: selectedDate) {
            getDateInfo(date: selectedDate)
        }
        .textSelection(.enabled)
    }
    
    func getDateInfo(date: Date) {
        let daysThisWeek = DateTimeUtility.getFirstAndLastDayOfWeek(calendar: calendar, date: date)
        startDate = daysThisWeek.firstDay
        endDate = daysThisWeek.lastDay
    }
}

#Preview {
    NavigationBar()
}
