//
//  NavigationBar.swift
//  mtimelog
//
//  Created by David Battefeld on 25.06.23.
//

import SwiftUI
import SwiftData

struct NavigationBar: View {
    @Query var workdays: [Workday]
    @State var showPopover = false
    
    var body: some View {
        List {
            Section(
                header: Text("STATIC: Calendar Week 4")
            ) {
                ForEach(workdays, id: \.self) { workday in
                    NavigationLink(destination: MainTaskList(workday: workday), label: {
                        Text(workday.date, format: .dateTime.day().month().year())
                    })
                }
            }
            Section {
                Button(action: {
                    showPopover = true
                }, label: {
                    Label("New workday", systemImage: "plus")
                })
                .buttonStyle(.plain)
                .popover(isPresented: $showPopover) {
                    AddNewWorkdaySheet()
                }
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
