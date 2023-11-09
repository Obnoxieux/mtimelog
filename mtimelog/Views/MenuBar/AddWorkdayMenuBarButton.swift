//
//  AddWorkdayMenuBarButton.swift
//  mtimelog
//
//  Created by David Battefeld on 09.11.23.
//

import SwiftUI

struct AddWorkdayMenuBarButton: View {
    @FocusedValue(\.addWorkday) private var addWorkday
    
    var body: some View {
        Button(action: {
            addWorkday?.wrappedValue = true
        }, label: {
            Label("New Working Day", systemImage: "plus")
        })
        .disabled(addWorkday == nil)
    }
}

#Preview {
    AddWorkdayMenuBarButton()
}
