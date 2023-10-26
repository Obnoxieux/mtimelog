//
//  DateOption.swift
//  mtimelog
//
//  Created by David Battefeld on 26.10.23.
//

import Foundation
import SwiftUI

enum DateOption: String, Identifiable, CaseIterable {
    case now
    case select
    
    var displayName: String { rawValue.capitalized }
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue.capitalized) }
    var id: String { self.rawValue }
}
