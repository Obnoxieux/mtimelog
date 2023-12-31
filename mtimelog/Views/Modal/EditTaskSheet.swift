//
//  EditTaskSheet.swift
//  mtimelog
//
//  Created by David Battefeld on 26.10.23.
//

import SwiftUI
import SwiftData

struct EditTaskSheet: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @Bindable var task: Task
    
    var mode: EditMode
    
    @State private var projectID = ""
    @State private var description = ""
    @State private var statusComment = ""
    @State private var selectedDateOption = DateOption.now
    @State private var startTime = Date.now
    @State private var endTime = Date.now
    @State private var status = TaskStatus.completed
    @State private var projectIDSuggestions = [String]()
    
    let suggestionProvider = SuggestionProvider()
    
    private var formValid: Bool {
        if projectID != "" && description != "" && startTime < endTime {
            return true
        } else {
            return false
        }
    }
    
    enum EditMode: String, Identifiable, CaseIterable {
        case finish
        case edit
        
        var displayName: String { rawValue.capitalized }
        var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue.capitalized) }
        var id: String { self.rawValue }
    }
    
    var body: some View {
        Form {
            Section(header: Text("General")) {
                if let workday = task.workday {
                    LabeledContent("Workday") {
                        Text(workday.date, format: .dateTime.day().month().year())
                    }
                }
                LabeledContent("Project ID*")  {
                    ComboBox(items: projectIDSuggestions, text: $projectID)
                }
                LabeledContent("Description*") {
                        TextEditor(text: $description)
                            .alignmentGuide(.firstTextBaseline) { $0[.firstTextBaseline] + 9 }
                            .multilineTextAlignment(.leading)
                    }
            }
            .padding(.vertical, 3)
            Section(header: Text("Time")) {
                if mode == .edit {
                    DatePicker("Start Time*", selection: $startTime)
                        .datePickerStyle(.compact)
                } else {
                    LabeledContent("Start Time") {
                        Text(task.startTime, format: .dateTime.hour().minute())
                    }
                }
                if mode == .finish {
                    Picker("Set End Time to", selection: $selectedDateOption) {
                        ForEach(DateOption.allCases) { option in
                            Text(option.localizedName)
                                .tag(option)
                        }
                    }
                    .pickerStyle(.inline)
                }
                
                if selectedDateOption == .select || mode == .edit {
                        DatePicker("End Time*", selection: $endTime)
                        .datePickerStyle(.compact)
                }
                Text("Note: changing the date component is only intended for correcting mistakes, the task is not automatically transferred to the corresponding working day.")
                    .foregroundStyle(.secondary)
                    .font(.callout)
            }
            .padding(.vertical, 3)
            Section(header: Text("Status Details")) {
                Picker("Status", selection: $status) {
                    if mode == .edit {
                        Text("Ongoing").tag(TaskStatus.ongoing)
                            .foregroundStyle(TaskStatus.ongoing.color)
                    }
                    Text("Completed").tag(TaskStatus.completed)
                        .foregroundStyle(TaskStatus.completed.color)
                    Text("Work in Progress").tag(TaskStatus.inProgress)
                        .foregroundStyle(TaskStatus.inProgress.color)
                    Text("Blocked").tag(TaskStatus.blocked)
                        .foregroundStyle(TaskStatus.blocked.color)
                }
                .pickerStyle(.inline)
                TextField("Status Comment", text: $statusComment)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(.vertical, 3)
            if mode == .finish {
                Section(header: Text("Usage Hints")) {
                    Text("Please add remaining data for the finished task. Fields marked with * are mandatory. You can edit everything later as well.")
                        .foregroundStyle(.secondary)
                }
            }
            HStack {
                Spacer()
                Button("Cancel") {
                    dismiss()
                }
                Button("Save Task") {
                    saveTask()
                    dismiss()
                }
                .disabled(!formValid)
                .buttonStyle(.borderedProminent)
                Spacer()
            }
            .padding()
        }
        .textSelection(.enabled)
        .frame(minWidth: 540, maxWidth: 700)
        .navigationTitle("Finish Task in \(task.projectID)")
        .formStyle(.grouped)
        
        .onAppear {
            initialiseView()
        }
        
        .onChange(of: selectedDateOption, {
            if selectedDateOption == .now {
                endTime = Date.now
            }
        })
        
        .task {
            do {
                let tasks = try modelContext.fetch(SuggestionProvider.taskDescriptor)
                let suggestions = try modelContext.fetch(SuggestionProvider.suggestionDescriptor)
                projectIDSuggestions = await suggestionProvider.loadSuggestions(fields: .id, tasks: tasks, suggestions: suggestions)
            } catch {
                print("couldn't load tasks via FetchDescriptor")
            }
        }
    }
    
    func saveTask() {
        task.update(
            projectID: projectID,
            taskDescription: description,
            statusComment: statusComment,
            status: status,
            startTime: startTime,
            endTime: endTime
        )
        do {
            try modelContext.save()
        } catch {
            print("couldn't immediately save deletion due to \(error.localizedDescription)")
        }
    }
    
    func initialiseView() {
        projectID = task.projectID
        description = task.taskDescription ?? ""
        startTime = task.startTime
        endTime = task.endTime ?? Date.now
        if mode == .edit {
            status = task.status
        }
        statusComment = task.statusComment ?? ""
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Task.self, configurations: config)
    
    let task = Task.sampleData[2]
    return EditTaskSheet(task: task, mode: EditTaskSheet.EditMode.edit)
        .frame(height: 700)
        .modelContainer(container)
}

//#Preview {
//    EditTaskSheet(task: Task.sampleData[2], mode: EditTaskSheet.EditMode.finish)
//        .frame(height: 700)
//}
