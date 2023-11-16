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
    @Environment(\.modelContext) private var modelContext
    @State var showAddPopover = false
    @State var searchText = ""
    @State var selectedTask: Task? = nil
    @Query var tasks: [Task]
    @Bindable var workday: Workday
    
    let pasteboard = NSPasteboard.general
    
    var filteredTasks: [Task] {
        guard searchText.isEmpty == false else { return tasks }
        return tasks.filter {
            $0.projectID.localizedStandardContains(searchText) ||
            ($0.taskDescription ?? "").localizedStandardContains(searchText) ||
            ($0.statusComment ?? "").localizedStandardContains(searchText)
        }
    }
    
    init(workday: Workday) {
        self.workday = workday
        pasteboard.declareTypes([.string], owner: nil)
        let id = workday.id
        let predicate = #Predicate<Task> { task in
            task.workday?.id == id
        }
        _tasks = Query(filter: predicate, sort: \Task.startTime, animation: .smooth)
    }
    
    var body: some View {
        List {
            Section(header: Text("Tasks")) {
                if tasks.isEmpty {
                    Label("This working day does not have any tasks yet.", systemImage: "tray")
                        .padding()
                }
                ForEach(filteredTasks, id: \.id) { (task) in
                    NavigationLink(destination: TaskDetail(task: task), label: {
                        TaskItem(task: task)
                            .listRowSeparatorTint(task.status.color)
                    })
                    .id(UUID())
                    .contextMenu {
                        Button("Copy Project ID") {
                            pasteboard.setString(task.projectID, forType: .string)
                        }
                        Button("Copy Description") {
                            pasteboard.setString(task.taskDescription ?? "", forType: .string)
                        }
                        Button("Copy ID + Description") {
                            pasteboard.setString(task.copyTaskTextToClipboard(includeProjectID: true), forType: .string)
                        }
                        Divider()
                        Button("Edit Task") {
                            self.selectedTask = task
                        }
                        Divider()
                        Button("Delete Task") {
                            deleteTask(task)
                        }
                    }
                }
                // this does work, but uses a trackpad swipe action which is not really intuitive on macOS and may not be available on all Macs
                .onDelete(perform: deleteTaskFromIndexSet)
                .listRowSeparator(.visible)
            }
            Section(header: Text("Stats")) {
                if workday.tasks.isEmpty {
                    Text("Once this working day has some tasks, you will see a chart here.")
                        .padding()
                } else {
                    WorkdayChart(workday: workday)
                        .padding()
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Tasks for \(workday.date.formatted(date: .long, time: .omitted))")
        .searchable(text: $searchText)
        .animation(.easeIn, value: tasks)
        
        .sheet(item: self.$selectedTask) { selectedTask in
            EditTaskSheet(task: selectedTask, mode: EditTaskSheet.EditMode.edit)
        }
        
        .toolbar {
            ToolbarItemGroup() {
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
                        .frame(minHeight: 300)
                }
            }
        }
        .focusedSceneValue(\.addTask, $showAddPopover)
    }
    
    func deleteTask(_ task: Task) {
        modelContext.delete(task)
        do {
            try modelContext.save()
        } catch {
            print("couldn't immediately save deletion")
        }
    }
    
    func deleteTaskFromIndexSet(_ indexSet: IndexSet) {
        for index in indexSet {
            let task = tasks[index]
            modelContext.delete(task)
            do {
                try modelContext.save()
            } catch {
                print("couldn't immediately save deletion")
            }
        }
    }
}

#Preview {
    MainTaskList(workday: Workday.sampleData[0])
}
