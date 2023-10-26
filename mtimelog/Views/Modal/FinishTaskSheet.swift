//
//  FinishTaskSheet.swift
//  mtimelog
//
//  Created by David Battefeld on 26.10.23.
//

import SwiftUI

struct FinishTaskSheet: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var task: Task
    
    @State private var projectID = ""
    @State private var description = ""
    @State private var statusComment = ""
    @State private var selectedDateOption = DateOption.now
    @State private var endTime = Date.now
    @State private var status = TaskStatus.completed
    
    private var formValid: Bool {
        if projectID != "" && description != "" && task.startTime < endTime {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("General")) {
                if let workday = task.workday {
                    LabeledContent("Workday") {
                        Text(workday.date, format: .dateTime.day().month().year())
                    }
                }
                TextField("Project ID*", text: $projectID)
                    .textFieldStyle(.roundedBorder)
                LabeledContent("Description*") {
                        TextEditor(text: $description)
                            .alignmentGuide(.firstTextBaseline) { $0[.firstTextBaseline] + 9 }
                            .multilineTextAlignment(.leading)
                    }
            }
            .padding(.vertical, 3)
            Section(header: Text("Time")) {
                LabeledContent("Start Time") {
                    Text(task.startTime, format: .dateTime.hour().minute())
                }
                Picker("Set End Time to", selection: $selectedDateOption) {
                    ForEach(DateOption.allCases) { option in
                        Text(option.localizedName)
                            .tag(option)
                    }
                }
                .pickerStyle(.inline)
                if selectedDateOption == .select {
                        DatePicker("End Time*", selection: $endTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.compact)
                }
            }
            .padding(.vertical, 3)
            Section(header: Text("Status Details")) {
                Picker("Status", selection: $status) {
                    Text("Completed").tag(TaskStatus.completed)
                    Text("Work in Progress").tag(TaskStatus.inProgress)
                    Text("Blocked").tag(TaskStatus.blocked)
                }
                .pickerStyle(.inline)
                TextField("Status Comment", text: $statusComment)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(.vertical, 3)
            Section(header: Text("Usage Hints")) {
                Text("Please add remaining data for the finished task. Fields marked with * are mandatory. You can edit everything later as well.")
                    .foregroundStyle(.secondary)
            }
            HStack {
                Spacer()
                Button("Cancel") {
                    dismiss()
                }
                Button("Finish Task") {
                    task.update(
                        projectID: projectID,
                        taskDescription: description,
                        statusComment: statusComment,
                        status: status,
                        endTime: endTime
                    )
                    dismiss()
                }
                .disabled(!formValid)
                .buttonStyle(.borderedProminent)
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Finish Task in \(task.projectID)")
        .formStyle(.grouped)
        
        .onAppear {
            projectID = task.projectID
            description = task.taskDescription ?? ""
        }
    }
}

#Preview {
    FinishTaskSheet(task: Task.sampleData[2])
        .frame(height: 700)
}
