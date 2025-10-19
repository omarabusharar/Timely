//
//  LabelView.swift
//  Timely
//
//  Created by Omar Abu Sharar on 10/19/25.
//

import SwiftUI

struct LabelView: View {
    var timeObject: TimeObject
    @Binding var selectedSet: TimeSet?
    var body: some View {
        if !(timeObject.didStart) {
            Label("Timer", systemImage: "clock")
        } else {
            HStack(spacing: 0) {
                Image(systemName: timeObject.reference.icon)
                Text(String(format: "%02d", timeObject.hours) + ":" + String(format: "%02d", timeObject.minutes) + ":" + String(format: "%02d", timeObject.seconds))
               
                    
            }
        }
    }
}

