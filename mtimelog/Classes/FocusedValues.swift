//
//  FocusedValues.swift
//  mtimelog
//
//  Created by David Battefeld on 09.11.23.
//

import Foundation
import SwiftUI

struct AddWorkdayKey: FocusedValueKey {
    typealias Value = Binding<Bool>
}

struct AddTaskKey: FocusedValueKey {
    typealias Value = Binding<Bool>
}

extension FocusedValues {
    var addWorkday: Binding<Bool>? {
        get { self[AddWorkdayKey.self] }
        set { self[AddWorkdayKey.self] = newValue }
    }
    var addTask: Binding<Bool>? {
        get { self[AddTaskKey.self] }
        set { self[AddTaskKey.self] = newValue }
    }
}
