//
//  ContentView.swift
//  Timely
//
//  Created by Omar Abu Sharar on 10/19/25.
//

import SwiftUI

let workSet = TimeSet(title: "Work", icon: "briefcase", hours: 1, minutes: 30, seconds: 0)
let breakSet = TimeSet(title: "Break", icon: "figure.walk", hours: 0, minutes: 15, seconds: 0)

struct ContentView: View {
   @Binding var selectedSet: TimeSet? 
   @Binding var timeObject: TimeObject
    @Environment(\.dismiss) var dismiss
    @Environment(\.openWindow) var openWindow
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {

                if (selectedSet?.title == workSet.title || !timeObject.isRunning) {
                        TimeCell(selectedSet: $selectedSet, set: workSet)
                        .onAppear {
                            selectedSet = workSet
                        }
                }
                    
                if (selectedSet?.title == breakSet.title || !timeObject.isRunning) {
                    TimeCell(selectedSet: $selectedSet, set: breakSet)
                }
  
                HStack(alignment: .firstTextBaseline) {
                    if (!timeObject.isRunning && timeObject.didStart) {
                        Button("Resume") {
                            // Resume timer action
                            timeObject.startTimer()
                        }
                        
                    } else {
                        Button("Pause") {
                            // Reset timer action
                            timeObject.pauseTimer()
                        }
                        .disabled(!timeObject.didStart)
                    }
                  
                
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

                    Spacer()
                    Menu("Menu", content: {
                        NavigationLink(destination: {
                            SettingsView()
                        }, label: {
                            Label("Settings", systemImage: "gear")
                        })
                        Button("About", systemImage: "info.circle") {
                            NSApp.orderFrontStandardAboutPanel(nil)
                        }
                        Button("Quit", systemImage: "xmark") {
                            NSApp.terminate(nil)
                        }
                    })
                    .font(.title)
                    .menuIndicator(.automatic)
                   
                  
                }
                .padding(.bottom)
            }
            .animation(.bouncy, value: timeObject.isRunning)
            .padding(.horizontal)
            .padding(.top)
        }
      
    }
}
