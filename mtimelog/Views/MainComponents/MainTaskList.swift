//
//  MainTaskList.swift
//  mtimelog
//
//  Created by David Battefeld on 25.06.23.
//

import SwiftUI

struct MainTaskList: View {
    @StateObject var vm = MainTaskListViewModel(workday: Workday.sampleData[0])
    
    var body: some View {
        List {
            ForEach(Task.sampleData, id: \.self) { task in
                TaskItem(task: task)
                    .listRowSeparatorTint(task.status.color)
            }
            .listRowSeparator(.visible)
        }
        .listStyle(.plain)
        .navigationTitle("Tasks")
            .toolbar {
                ToolbarItemGroup(placement: .secondaryAction) {
                    Button {
                        // create
                    } label: {
                        Image(systemName: "square.and.pencil")
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
        MainTaskList()
    }
}
