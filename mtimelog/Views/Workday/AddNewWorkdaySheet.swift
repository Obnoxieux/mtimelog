//
//  AddNewWorkdaySheet.swift
//  mtimelog
//
//  Created by David Battefeld on 27.06.23.
//

import SwiftUI

struct AddNewWorkdaySheet: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var date = Date.now
    
    var body: some View {
        Form {
            Text("Select the day for which you want to track your time:")
                .foregroundStyle(.secondary)
            DatePicker("Working Day Date", selection: $date, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .padding(.vertical, 5)
            HStack {
                Spacer()
                Button("Cancel") {
                    dismiss()
                }
                Button("Save") {
                    modelContext.insert(Workday(date: date))
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .formStyle(.grouped)
    }
}

struct AddNewWorkdaySheet_Previews: PreviewProvider {
    static var previews: some View {
        AddNewWorkdaySheet()
    }
}
