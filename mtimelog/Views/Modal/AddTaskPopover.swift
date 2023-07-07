//
//  AddTaskPopover.swift
//  mtimelog
//
//  Created by David Battefeld on 07.07.23.
//

import SwiftUI

struct AddTaskPopover: View {
    @Environment(\.dismiss) var dismiss
    
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
    
    enum DateOption: String, Identifiable, CaseIterable {
        case now
        case select
        
        var displayName: String { rawValue.capitalized }
        var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue.capitalized) }
        var id: String { self.rawValue }
    }
    
    var body: some View {
        Form {
            TextField("Project Name", text: $projectID)
            TextField("Description", text: $description)
            Text("You can fill out the description later upon finishing the task.")
                .foregroundColor(.secondary)
                .padding(.bottom)
            Picker("Start Time", selection: $selectedDateOption) {
                ForEach(DateOption.allCases) { option in
                    Text(option.localizedName)
                        .tag(option)
                }
            }
            .pickerStyle(.inline)
            if selectedDateOption == .select {
                DatePicker("Please enter a date", selection: $time, displayedComponents: .hourAndMinute)
                    .labelsHidden()
            }
            HStack {
                Spacer()
                Button("Cancel") {
                    dismiss()
                }
                Button("Add Task") {
                    // TODO: things
                    dismiss()
                }
                .disabled(!formValid)
                .buttonStyle(.borderedProminent)
            }
        }
        .formStyle(.columns)
        .padding()
    }
}

struct AddTaskPopover_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskPopover()
    }
}
