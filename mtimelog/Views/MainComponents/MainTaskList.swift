//
//  MainTaskList.swift
//  mtimelog
//
//  Created by David Battefeld on 25.06.23.
//

import SwiftUI
import SwiftData

struct MainTaskList: View {
    @AppStorage("showTimesInReport") var showTimesInReport = true
    @State var showAddPopover = false
    @Query var tasks: [Task]
    @Bindable var workday: Workday
    
    init(workday: Workday) {
        self.workday = workday
        let id = workday.id
        let predicate = #Predicate<Task> { task in
            task.workday?.id == id
        }
        _tasks = Query(filter: predicate, sort: \Task.startTime, animation: .smooth)
    }
    
    var body: some View {
        List {
            if tasks.isEmpty {
                Label("This working day does not have any tasks yet.", systemImage: "tray")
                    .padding()
            }
            ForEach(tasks, id: \.self) { task in
                NavigationLink(destination: TaskDetail(task: task), label: {
                    TaskItem(task: task)
                        .listRowSeparatorTint(task.status.color)
                })
            }
            .listRowSeparator(.visible)
        }
        .onDeleteCommand(perform: {
            //
        })
        .listStyle(.plain)
        .navigationTitle("Tasks for \(workday.date.formatted(date: .long, time: .omitted))")
        .toolbar {
            ToolbarItemGroup(placement: .secondaryAction) {
                Button {
                    showAddPopover = true
                } label: {
                    Label("Add Task", systemImage: "plus")
                        .labelStyle(.titleAndIcon)
                }
                ShareLink(item: workday.generateReport(includeDuration: showTimesInReport)) {
                    Label("Daily Report", systemImage: "square.and.arrow.up")
                        .labelStyle(.titleAndIcon)
                }
                .popover(isPresented: $showAddPopover, arrowEdge: .bottom) {
                    AddTaskPopover(workday: workday)
                }
            }
        }
    }
}

#Preview {
    MainTaskList(workday: Workday.sampleData[0])
}
