//
//  AddTaskPopover.swift
//  mtimelog
//
//  Created by David Battefeld on 07.07.23.
//

import SwiftUI

struct AddTaskPopover: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var workday: Workday
    
    @State private var projectID = ""
    @State private var description = ""
    @State private var selectedDateOption = DateOption.now
    @State private var time = Date.now
    
    
    private var formValid: Bool {
        if projectID != "" {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        Form {
            TextField("Project Name", text: $projectID) //TODO: combo box
            TextField("Description", text: $description)
            Text("You can fill out the description later upon finishing the task.")
                .foregroundColor(.secondary)
                .padding(.bottom)
            Picker("Set Start Time to", selection: $selectedDateOption) {
                ForEach(DateOption.allCases) { option in
                    Text(option.localizedName)
                        .tag(option)
                }
            }
            .pickerStyle(.inline)
            if selectedDateOption == .select {
                DatePicker("Start Time", selection: $time, displayedComponents: .hourAndMinute)
            }
            HStack {
                Spacer()
                Button("Cancel") {
                    dismiss()
                }
                Button("Add Task") {
                    addNewTask()
                    dismiss()
                }
                .disabled(!formValid)
                .buttonStyle(.borderedProminent)
            }
        }
        .formStyle(.grouped)
    }
    
    func addNewTask() {
        let task = Task(
            projectID: projectID,
            taskDescription: description,
            status: .ongoing,
            startTime: time,
            workday: workday
        )
        workday.addTask(task: task)
    }
}

struct AddTaskPopover_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskPopover(workday: Workday.sampleData[0])
    }
}
