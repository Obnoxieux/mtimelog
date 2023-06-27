//
//  AddNewWorkdaySheet.swift
//  mtimelog
//
//  Created by David Battefeld on 27.06.23.
//

import SwiftUI

struct AddNewWorkdaySheet: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var date = Date.now
    @ObservedObject var vm: NavigationBar.NavigationBarViewModel
    
    var body: some View {
        Form {
            Text("Select the day for which you want to track your time:")
            DatePicker("Please enter a date", selection: $date, displayedComponents: .date)
                .labelsHidden()
                .padding(.vertical, 5)
            HStack {
                Spacer()
                Button("Cancel") {
                    dismiss()
                }
                Button("Save") {
                    vm.addNewWorkday(date: date)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .formStyle(.columns)
        .padding()
    }
}

struct AddNewWorkdaySheet_Previews: PreviewProvider {
    static var previews: some View {
        AddNewWorkdaySheet(vm: NavigationBar.NavigationBarViewModel())
    }
}
