//
//  ContentView.swift
//  Timely
//
//  Created by Omar Abu Sharar on 10/19/25.
//

import SwiftUI

struct ContentView: View {
   @Binding var selectedSet: TimeSet?
   @Binding var timeObject: TimeObject
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Timely")
                        .font(.title3)
                        .fontWidth(.expanded)
                        .fontWeight(.bold)
                    Spacer()
                    NavigationLink(destination: {
                        SettingsView()
                    }, label: {
                       Label("Settings", systemImage: "gear")
                    })
               
                    .labelStyle(.iconOnly)
                }
                TimeCell(selectedSet: $selectedSet, set: .init(title: "Work", icon: "briefcase", hours: 1, minutes: 30, seconds: 0))
                
                Spacer()
                TimeCell(selectedSet: $selectedSet, set: .init(title: "Break", icon: "figure.walk", hours: 0, minutes: 15, seconds: 0))
                Spacer()
                Divider()
                HStack {
                    if (timeObject.isRunning) {
                        Button("Pause") {
                            // Reset timer action
                            timeObject.pauseTimer()
                        }
                    } else if (timeObject.didStart) {
                        Button("Resume") {
                            // Resume timer action
                            timeObject.startTimer()
                        }
                        
                    }
                    Spacer()
                    if (timeObject.didStart) {
                       
                        Button("Stop") {
                            // Stop timer action
                            timeObject.stopTimer()
                        }
                    } else {
                        Button("Start") {
                            // Start timer action
                            if let ref = selectedSet {
                                timeObject = TimeObject(reference: ref)
                            }
                            timeObject.startTimer()
                        }
                        .disabled(selectedSet == nil)
                    }
                   
                   
                   
                    Button("Quit") {
                        NSApp.terminate(nil)
                    }
                }
                .padding(.bottom)
            }
            .padding(.horizontal)
            .padding(.top)
        }
        .frame(width: 300, height: 200)
    }
}
