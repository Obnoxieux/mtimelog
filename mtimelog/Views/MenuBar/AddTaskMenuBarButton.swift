//
//  AddTaskMenuBarButton.swift
//  mtimelog
//
//  Created by David Battefeld on 09.11.23.
//

import SwiftUI

struct AddTaskMenuBarButton: View {
    @FocusedValue(\.addTask) private var addTask
    var body: some View {
        Button {
            addTask?.wrappedValue = true
        } label: {
            Label("Add Task", systemImage: "plus")
        }
        .disabled(addTask == nil)
    }
}

#Preview {
    AddTaskMenuBarButton()
}
