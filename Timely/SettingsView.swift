//
//  SettingsView.swift
//  Timely
//
//  Created by Omar Abu Sharar on 10/19/25.
//

import SwiftUI

struct SettingsView: View {
    @State private var workHours: Int = 0
    var body: some View {
        ScrollView {
            Form {
                Section("Work", content: {
                   TimePicker(value: $workHours, title: "Hours", limit: (0, 24))
                })
            }
        }
        .navigationTitle("Settings")
        .toolbarTitleDisplayMode(.inline)
        .toolbarBackgroundVisibility(.hidden, for: .windowToolbar)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
