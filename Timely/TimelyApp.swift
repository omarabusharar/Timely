//
//  TimelyApp.swift
//  Timely
//
//  Created by Omar Abu Sharar on 10/19/25.
//

import SwiftUI

@main
struct TimelyApp: App {
    @State private var selectedSet: TimeSet? = nil
    @State private var timeObject: TimeObject = TimeObject(reference: .init(title: "Sample", icon: "clock", hours: 0, minutes: 1, seconds: 0))
    var body: some Scene {
        MenuBarExtra(content: {
            ContentView(selectedSet: $selectedSet, timeObject: $timeObject)
        }, label: {
            LabelView(timeObject: timeObject, selectedSet: $selectedSet)
        })
        .menuBarExtraStyle(.window)
    }
}
