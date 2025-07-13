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
    @AppStorage("reportEmailRecipient") var reportEmailRecipient = ""
    @AppStorage("reportEmailFormat") var reportEmailFormat = ReportEmailFormat
        .plainText

    var body: some View {
        Form {
            TextField(
                "Hours per Working Day",
                value: $hoursInWorkingDay,
                format: .number
            )
            .textFieldStyle(.roundedBorder)

            Toggle(
                "Include task times and duration in report",
                isOn: $showTimesInReport
            )

            Picker("Report Email Format", selection: $reportEmailFormat) {
                Text("Plain Text").tag(ReportEmailFormat.plainText)
                Text("HTML").tag(ReportEmailFormat.html)
            }
            .pickerStyle(.inline)

            TextField("Report Email Recipient", text: $reportEmailRecipient)
                .textContentType(.emailAddress)
                .textFieldStyle(.roundedBorder)
        }
        .textSelection(.enabled)
        .formStyle(.grouped)
    }
}

#Preview {
    GeneralSettingsTab()
}
