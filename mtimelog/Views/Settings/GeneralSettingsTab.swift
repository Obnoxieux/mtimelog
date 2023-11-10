//
//  GeneralSettingsTab.swift
//  mtimelog
//
//  Created by David Battefeld on 25.10.23.
//

import SwiftUI

struct GeneralSettingsTab: View {
    @AppStorage("hoursInWorkingDay") var hoursInWorkingDay = 8
    @AppStorage("showTimesInReport") var showTimesInReport = true
    
    var body: some View {
        Form {
            TextField("Hours per Working Day", value: $hoursInWorkingDay, format: .number)
                .textFieldStyle(.roundedBorder)
            Toggle("Include task times and duration in report", isOn: $showTimesInReport)
        }
        .textSelection(.enabled)
        .formStyle(.grouped)
    }
}

#Preview {
    GeneralSettingsTab()
}
