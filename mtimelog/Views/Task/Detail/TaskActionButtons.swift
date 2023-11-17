//
//  TaskActionButtons.swift
//  mtimelog
//
//  Created by David Battefeld on 17.11.23.
//

import SwiftUI

struct TaskActionButtons: View {
    var task: Task
    
    @Binding var showFinishSheet: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Button("Copy description") {
                let pasteboard = NSPasteboard.general
                pasteboard.declareTypes([.string], owner: nil)
                pasteboard.setString(task.copyTaskTextToClipboard(includeProjectID: false), forType: .string)
            }
            switch task.status {
            case .ongoing:
                HStack {
                    Button("Finish Task") {
                        showFinishSheet = true
                    }
                    .buttonStyle(.borderedProminent)
                }
            default:
                Button("Copy Task Info") {
                    let pasteboard = NSPasteboard.general
                    pasteboard.declareTypes([.string], owner: nil)
                    pasteboard.setString(task.copyTaskTextToClipboard(includeProjectID: true), forType: .string)
                }
            }
            Spacer()
        }
        .padding()
        .modifier(TaskDetailCardBackground())
    }
}

#Preview {
    TaskActionButtons(task: Task.sampleData[0], showFinishSheet: .constant(false))
}
