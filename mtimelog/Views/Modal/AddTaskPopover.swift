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
    
    static let MAX_SUGGESTIONS = 45
    
    static var descriptor: FetchDescriptor<Task> {
        var descriptor = FetchDescriptor<Task>(sortBy: [SortDescriptor(\.startTime, order: .reverse)])
        descriptor.fetchLimit = self.MAX_SUGGESTIONS
        descriptor.propertiesToFetch = [\.projectID, \.taskDescription]
        return descriptor
    }
    
    private var formValid: Bool {
        if projectID != "" {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        Form {
            LabeledContent("Project Name")  {
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
        .formStyle(.grouped)
        
        .task {
            await loadSuggestions()
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
    
    func loadSuggestions() async {
        do {
            let tasks = try modelContext.fetch(AddTaskPopover.descriptor)
            var idSuggestionSet = Set<String>()
            var descSuggestionSet = Set<String>()
            
            for task in tasks {
                idSuggestionSet.insert(task.projectID)
                if let desc = task.taskDescription {
                    descSuggestionSet.insert(desc)
                }
            }
            idSuggestionSet.remove("")
            descSuggestionSet.remove("")
            projectIDSuggestions = Array(idSuggestionSet)
            descriptionSuggestions = Array(descSuggestionSet)
        } catch {
            print("couldn't load tasks via FetchDescriptor")
        }
    }
}

struct AddTaskPopover_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskPopover(workday: Workday.sampleData[0])
    }
}
