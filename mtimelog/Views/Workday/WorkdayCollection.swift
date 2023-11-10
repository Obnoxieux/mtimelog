//
//  WorkdayCollection.swift
//  mtimelog
//
//  Created by David Battefeld on 10.11.23.
//

import SwiftUI
import SwiftData

struct WorkdayCollection: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.calendar) var calendar
    @Query var workdays: [Workday]
    
    @State private var workdayToDelete: Workday? = nil
    @State var showingDeleteConfirmationDialog = false
    @State var showPopover = false
    
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
        ForEach(workdays, id: \.self) { workday in
            NavigationLink(destination: MainTaskList(workday: workday), label: {
                Text(workday.date, format: .dateTime.weekday().day().month().year())
            })
            .contextMenu {
                Button("Delete Working Day") {
                    workdayToDelete = workday
                    showingDeleteConfirmationDialog = true
                }
            }
        }
        Divider()
        Button(action: {
            showPopover = true
        }, label: {
            Label("New working day", systemImage: "plus")
        })
        .buttonStyle(.plain)
        
        .popover(isPresented: $showPopover) {
            AddNewWorkdaySheet()
        }
            
        .confirmationDialog("Confirm Deletion", isPresented: $showingDeleteConfirmationDialog) {
            Button("Delete Working Day", role: .destructive) {
                if let workday = workdayToDelete {
                    modelContext.delete(workday)
                    do {
                        try modelContext.save()
                    } catch {
                        print("couldn't immediately save deletion")
                    }
                    workdayToDelete = nil
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("The working day and all tasks associated with it will be irrevocably deleted!")
        }
        .focusedSceneValue(\.addWorkday, $showPopover)
    }
}

#Preview {
    WorkdayCollection(startDate: .now, endDate: .now)
}
