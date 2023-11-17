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
                TaskDetailMainInfo(task: task)
                TaskDetailTimeSection(task: task)
                TaskDetailStatusSection(task: task)
                switch task.status {
                case .ongoing:
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
                    Button("Copy Task Info") {
                        let pasteboard = NSPasteboard.general
                        pasteboard.declareTypes([.string], owner: nil)
                        pasteboard.setString(task.copyTaskTextToClipboard(includeProjectID: true), forType: .string)
                    }
                    .padding(.vertical)
                }
            }
            .textSelection(.enabled)
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
        .frame(height: 600)
}
#Preview {
    TaskDetail(task: Task.sampleData[1])
        .frame(height: 600)
}
