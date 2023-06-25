//
//  Task.swift
//  mtimelog
//
//  Created by David Battefeld on 25.06.23.
//

import Foundation

struct Task: Hashable, Codable, Identifiable {
    var id = UUID()
    var projectID: String
    var description: String
    var startTime: Date
    var endTime: Date
    
    func getDuration() {
        //TODO: calculate
    }
}
