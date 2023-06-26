//
//  TaskStatus.swift
//  mtimelog
//
//  Created by David Battefeld on 26.06.23.
//

import SwiftUI

enum TaskStatus: String, Codable {
    case inProgress
    case completed
    case blocked
    
    var color: Color {
        switch self {
        case .inProgress: return .yellow
        case .blocked: return .red
        case .completed: return .green
        }
    }
}
