//
//  SettingsView.swift
//  Timely
//
//  Created by Omar Abu Sharar on 10/19/25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("workHours") private var workHours: Int = 1
    @AppStorage("workMinutes") private var workMins: Int = 30
    @AppStorage("workSeconds") private var workSeconds: Int = 0
    
    @AppStorage("breakHours") private var breakHours: Int = 0
    @AppStorage("breakMinutes") private var breakMins: Int = 15
    @AppStorage("breakSeconds") private var breakSeconds: Int = 0
    
    @AppStorage("Continous") private var continous: Bool = true
    var body: some View {
        List {
            Text("Settings need restart of Timely to properly take effect")
            TimePickerSection(title: "Work", hours: $workHours, mins: $workMins, seconds: $workSeconds)
            TimePickerSection(title: "Break", hours: $breakHours, mins: $breakMins, seconds: $breakSeconds)
            Section(content: {
                Toggle("Continous", isOn: $continous)
            }, footer: {
                Text("Cycle between work and break automatically")
            })
        }
        .listRowSeparator(.hidden)
        .navigationTitle("Settings")
        
    }
}

struct TimePickerSection: View {
    var title: String
    @Binding var hours: Int
    @Binding var mins: Int
    @Binding var seconds: Int
    var body: some View {
        Section(title, content: {
           TimePicker(value: $hours, title: "Hours", limit: (0, 24))
           TimePicker(value: $mins, title: "Minutes", limit: (0, 60))
           TimePicker(value: $seconds, title: "Seconds", limit: (0, 60))
        })
    }
}


struct TimePicker: View {
    @Binding var value: Int
    var title: String
    var limit: (Int, Int)
    var body: some View {
        Picker(selection: $value, label: Text(title)) {
            ForEach(limit.0...limit.1, id: \.self) { num in
                Text("\(num)").tag(num)
            }
        }
    }
}


#Preview {
    SettingsView()
}
