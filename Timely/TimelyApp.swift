//
//  TimelyApp.swift
//  Timely
//
//  Created by Omar Abu Sharar on 10/19/25.
//

import SwiftUI

@main
struct TimelyApp: App {
    @State private var selectedSet: TimeSet? = TimeSet.work
    @State private var timeObject: TimeObject = TimeObject(reference: .init(title: "Sample", icon: "clock", hours: 0, minutes: 1, seconds: 0))
    @AppStorage("didInitialize") var didInitialize: Bool = false
    init() {
            #if DEBUG
            UserDefaults.standard.removePersistentDomain(
                forName: Bundle.main.bundleIdentifier!
            )
            #endif
            if !didInitialize {
                TimeSet.initializeDefaults(for: "work", values: (1,30,0))
                TimeSet.initializeDefaults(for: "break", values: (0,15,0))
                didInitialize = true
            }
        }
    
    var body: some Scene {
        MenuBarExtra(content: {
            ContentView(selectedSet: $selectedSet, timeObject: $timeObject)
        }, label: {
            LabelView(timeObject: timeObject, selectedSet: $selectedSet)
        })
        .menuBarExtraStyle(.window)
        
    }
}
