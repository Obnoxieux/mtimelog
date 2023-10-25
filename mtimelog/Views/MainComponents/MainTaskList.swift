//
//  MainTaskList.swift
//  mtimelog
//
//  Created by David Battefeld on 25.06.23.
//

import SwiftUI

struct MainTaskList: View {
    @State var showAddPopover = false
    
    var workday: Workday
    
    var body: some View {
        List {
            ForEach(workday.tasks, id: \.self) { task in
                NavigationLink(destination: TaskDetail(task: task), label: {
                    TaskItem(task: task)
                        .listRowSeparatorTint(task.status.color)
                })
            }
            .listRowSeparator(.visible)
        }
        .listStyle(.plain)
        .navigationTitle("Tasks for \(workday.date.formatted(date: .long, time: .omitted))")
            .toolbar {
                ToolbarItemGroup(placement: .secondaryAction) {
                    Button {
                        showAddPopover = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .popover(isPresented: $showAddPopover, arrowEdge: .bottom) {
                        AddTaskPopover(workday: workday)
                    }
                    Spacer()
                    HStack {
                        Button {
                            // edit
                        } label: {
                            Image(systemName: "rectangle.and.pencil.and.ellipsis")
                        }
                        Button {
                            // delete
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                    Spacer(minLength: 500)
                    ShareLink(item: "bogus")
                }
            }
    }
}

struct MainTaskList_Previews: PreviewProvider {
    static var previews: some View {
        MainTaskList(workday: Workday.sampleData[0])
    }
}
