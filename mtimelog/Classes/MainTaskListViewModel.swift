//
//  File.swift
//  mtimelog
//
//  Created by David Battefeld on 26.06.23.
//

import Foundation

@available(*, deprecated, message: "switched to MV pattern")
@Observable class MainTaskListViewModel {
    var workday: Workday
    
    init(workday: Workday) {
        self.workday = workday
    }
}
