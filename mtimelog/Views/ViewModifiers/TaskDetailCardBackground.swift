//
//  TaskDetailCardBackground.swift
//  mtimelog
//
//  Created by David Battefeld on 17.11.23.
//

import Foundation
import SwiftUI

struct TaskDetailCardBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.thickMaterial)
            .cornerRadius(14)
            .shadow(radius: 0, x: 4, y: 4)
    }
}

struct VisualEffect: NSViewRepresentable {
  func makeNSView(context: Self.Context) -> NSView { return NSVisualEffectView() }
  func updateNSView(_ nsView: NSView, context: Context) { }
}
