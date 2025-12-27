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
    @Environment(\.openWindow) var openWindow
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                if (selectedSet?.title == TimeSet.work.title || !timeObject.isRunning) {
                        TimeCell(selectedSet: $selectedSet, set: TimeSet.work)
                        .onAppear {
                            selectedSet = TimeSet.work
                        }
                }
                    
                if (selectedSet?.title == TimeSet.recess.title || !timeObject.isRunning) {
                    TimeCell(selectedSet: $selectedSet, set: TimeSet.recess)
                }
  
                HStack(alignment: .firstTextBaseline) {
                    if (!timeObject.isRunning && timeObject.didStart) {
                        Button("Resume") {
                            timeObject.startTimer()
                        }
                    } else {
                        Button("Pause") {
                            timeObject.pauseTimer()
                        }
                        .disabled(!timeObject.didStart)
                    }
                  
                
                    if (timeObject.didStart) {
                       
                        Button("Stop") {
                            timeObject.stopTimer()
                        }
                    } else {
                        Button("Start") {
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
