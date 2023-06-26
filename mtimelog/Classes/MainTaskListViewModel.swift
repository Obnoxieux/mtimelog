//
//  File.swift
//  mtimelog
//
//  Created by David Battefeld on 26.06.23.
//

import Foundation

extension MainTaskList {
    class MainTaskListViewModel: ObservableObject {
        @Published var workday: Workday
        
        init(workday: Workday) {
            self.workday = workday
        }
    }
}
