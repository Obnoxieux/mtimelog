//
//  NavigationBar.swift
//  mtimelog
//
//  Created by David Battefeld on 25.06.23.
//

import SwiftUI

struct NavigationBar: View {
    @StateObject var vm = NavigationBarViewModel()
    @State var showPopover = false
    
    var body: some View {
        List {
            Section(
                header: Text("Calendar Week 4")
            ) {
                ForEach(vm.workdays, id: \.self) { workday in
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
            }
        }
        .listStyle(.sidebar)
        .navigationTitle("Workdays")
        .popover(isPresented: $showPopover) {
            AddNewWorkdaySheet(vm: vm)
        }
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
    }
}
