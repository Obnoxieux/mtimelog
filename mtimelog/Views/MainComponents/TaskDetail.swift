//
//  TaskDetail.swift
//  mtimelog
//
//  Created by David Battefeld on 25.06.23.
//

import SwiftUI

struct TaskDetail: View {
    @AppStorage("hoursInWorkingDay") var hoursInWorkingDay = 8
    @State var showFinishSheet = false
    @State var showEditSheet = false
    @State var showingDeleteConfirmationDialog = false
    @Environment(\.modelContext) private var modelContext
    
    @State private var taskDeleted = false
    
    @Bindable var task: Task
    
    let listPadding: CGFloat = 7
    
    var body: some View {
        if taskDeleted == false {
            List {
                let gaugePercentage = task.calculatePercentageOfWorkingDay(hoursInWorkingDay: hoursInWorkingDay)
                switch task.status {
                    
                case .ongoing:
                    TaskDetailMainInfo(task: task)
                        .padding(.vertical, listPadding)
                    VStack(spacing: 10) {
                        HStack {
                            Text("Started: ") + Text(task.startTime, style: .time).font(.headline)
                            Spacer()
                            Text(task.startTime, style: .timer)
                                .font(.headline)
                        }
                        .padding(.vertical, listPadding)
                        
                        
                        Gauge(value: gaugePercentage) {
                            Text("% of Workday")
                        }
                        .padding(.vertical, listPadding)
                    }
                    Label(task.status.rawValue, systemImage: "info.square")
                        .foregroundColor(task.status.color)
                        .padding(.vertical, listPadding)
                    HStack {
                        Spacer()
                        Button("Finish Task") {
                            showFinishSheet = true
                        }
                        .buttonStyle(.borderedProminent)
                        Spacer()
                    }
                    .padding(.vertical, listPadding)
                    
                default:
                    TaskDetailMainInfo(task: task)
                        .padding(.vertical, listPadding)
                    if let endTime = task.endTime {
                        HStack {
                            Image(systemName: "clock")
                                .foregroundColor(.accentColor)
                            Text(task.startTime...endTime)
                        }
                        .padding(.vertical, listPadding)
                        Label(task.getDuration(), systemImage: "hourglass")
                            .padding(.vertical, listPadding)
                        Gauge(value: gaugePercentage) {
                            Text("% of Workday")
                        }
                        .padding(.vertical, listPadding)
                    }
                    if let comment = task.statusComment {
                        Label(comment, systemImage: task.status == .blocked ? "exclamationmark.bubble" : "bubble.left")
                            .padding(.vertical, listPadding)
                    }
                    Label(task.status.rawValue, systemImage: "info.square")
                        .foregroundColor(task.status.color)
                        .padding(.vertical, listPadding)
                }
            }
            .sheet(isPresented: $showFinishSheet) {
                EditTaskSheet(task: task, mode: EditTaskSheet.EditMode.finish)
            }
            .sheet(isPresented: $showEditSheet) {
                EditTaskSheet(task: task, mode: EditTaskSheet.EditMode.edit)
            }
            .confirmationDialog("Confirm Deletion", isPresented: $showingDeleteConfirmationDialog) {
                Button("Delete Task", role: .destructive) {
                    taskDeleted = true
                    modelContext.delete(task)
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This task will be deleted from its corresponding working day.")
            }
            .toolbar {
                ToolbarItemGroup {
                    Spacer()
                    Button {
                        showEditSheet = true
                    } label: {
                        Label("Edit", systemImage: "pencil.and.list.clipboard")
                            .labelStyle(.titleAndIcon)
                    }
                    Button {
                        showingDeleteConfirmationDialog = true
                    } label: {
                        Label("Delete", systemImage: "trash")
                            .labelStyle(.titleAndIcon)
                    }
                }
            }
        } else {
            ContentUnavailableView("No Task selected", systemImage: "note.text")
        }
    }
}

#Preview {
    TaskDetail(task: Task.sampleData[0])
}
