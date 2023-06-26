//
//  NavigationBar.swift
//  mtimelog
//
//  Created by David Battefeld on 25.06.23.
//

import SwiftUI

struct NavigationBar: View {
    @State private var date = Date.now
    
    var body: some View {
        List {
            Section(
                header: Text("Calendar Week 4")
            ) {
                Text("23-10-02")
                Text("23-10-03")
                Text("23-10-04")
                Text("23-10-05")
            }
            Section {
                DatePicker("Please enter a date", selection: $date, displayedComponents: .date)
                    .labelsHidden()
            }
        }
        .listStyle(.sidebar)
        .navigationTitle("Workdays")
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
    }
}
