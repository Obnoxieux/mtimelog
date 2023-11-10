//
//  AddTaskPopover.swift
//  mtimelog
//
//  Created by David Battefeld on 07.07.23.
//

import SwiftUI
import SwiftData

struct AddTaskPopover: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @Bindable var workday: Workday
    
    @State private var projectID = ""
    @State private var description = ""
    @State private var selectedDateOption = DateOption.now
    @State private var time = Date.now
    @State private var projectIDSuggestions = [String]()
    @State private var descriptionSuggestions = [String]()
    
    let suggestionProvider = SuggestionProvider()
    
    private var formValid: Bool {
        if projectID != "" {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        Form {
            LabeledContent("Project ID")  {
                ComboBox(items: projectIDSuggestions, text: $projectID)
            }
            LabeledContent("Description")  {
                ComboBox(items: descriptionSuggestions, text: $description)
            }
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
        .textSelection(.enabled)
        .formStyle(.grouped)
        
        .task {
            do {
                let tasks = try modelContext.fetch(SuggestionProvider.descriptor)
                projectIDSuggestions = await suggestionProvider.loadSuggestions(fields: .id, tasks: tasks)
                descriptionSuggestions = await suggestionProvider.loadSuggestions(fields: .desc, tasks: tasks)
            } catch {
                print("couldn't load tasks via FetchDescriptor")
            }
        }
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
