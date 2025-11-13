//
//  CompleteView.swift
//  Timely
//
//  Created by Omar Abu Sharar on 11/13/25.
//

import SwiftUI

struct CompleteView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 30))
            VStack {
                Text("Timer Complete")
                    .font(.headline)
                Text("Work")
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Button(action: {
               for window in NSApp.windows {
                   if let panel = window as? NSPanel, panel.title == "Timer Complete" {
                       animateClose(panel)
                   }
               }
            }, label: {
                Image(systemName: "xmark")
                    .font(.system(size: 10))
                    .padding(5)
            })
            .buttonStyle(.bordered)
            .buttonBorderShape(.circle)
        }
        .padding()
        .frame(width: 250, height: 60)
        .background {
            if #available(macOS 26, *) {
                Capsule()
                    .fill(.clear)
                    .glassEffect(.clear, in: Capsule())
            } else {
                Capsule()
                    .fill(.ultraThinMaterial)
            }
            
        }
    }
    private func animateClose(_ panel: NSPanel) {
           NSAnimationContext.runAnimationGroup({ context in
               context.duration = 0.25
               panel.animator().alphaValue = 0.0
           }, completionHandler: {
               panel.orderOut(nil)  // Hide first to avoid flicker
               panel.close()
           })
       }
}

// Helper to create a floating window near menu bar
func showFloatingAlert() {
    let panel = NSPanel(
        contentRect: NSRect(x: 0, y: 0, width: 200, height: 120),
        styleMask: [.nonactivatingPanel, .borderless, .hudWindow],
        backing: .buffered,
        defer: false
    )
    panel.title = "Timer Complete"
    panel.level = .popUpMenu
    panel.isFloatingPanel = true
    panel.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
    panel.titleVisibility = .hidden
    panel.titlebarAppearsTransparent = true
    panel.backgroundColor = .clear
    panel.hasShadow = true
    panel.isMovable = false
    // Position near menu bar
    if let screen = NSScreen.main {
        let x = screen.frame.maxX - panel.frame.width - 100
        let y = screen.frame.maxY - 100
        panel.setFrameOrigin(NSPoint(x: x, y: y))
    }

    panel.contentView = NSHostingView(rootView: CompleteView())
    panel.makeKeyAndOrderFront(nil)
}

#Preview {
    CompleteView()
}

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
