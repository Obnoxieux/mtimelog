//
//  GeneralSettingsTab.swift
//  mtimelog
//
//  Created by David Battefeld on 25.10.23.
//

import SwiftUI

struct GeneralSettingsTab: View {
    @AppStorage("hoursInWorkingDay") var hoursInWorkingDay = 8
    
    var body: some View {
        VStack() {
            HStack {
                Text("Hours per Working Day")
                TextField("Hours per Working Day", value: $hoursInWorkingDay, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: 40)
                Spacer()
            }
            .padding()
            Spacer()
        }
    }
}

#Preview {
    GeneralSettingsTab()
}
