//
//  NavigationBarViewModel.swift
//  mtimelog
//
//  Created by David Battefeld on 27.06.23.
//

import Foundation

extension NavigationBar {
    class NavigationBarViewModel: ObservableObject {
        @Published var workdays: [Workday] = []
        
        func addNewWorkday(date: Date) {
            workdays.append(Workday(date: date))
        }
    }
}
