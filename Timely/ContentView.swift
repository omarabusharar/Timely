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
    @AppStorage("workHours") private var workHours: Int = 1
    @AppStorage("workMinutes") private var workMins: Int = 30
    @AppStorage("workSeconds") private var workSeconds: Int = 0
    @AppStorage("breakHours") private var breakHours: Int = 0
    @AppStorage("breakMinutes") private var breakMins: Int = 15
    @AppStorage("breakSeconds") private var breakSeconds: Int = 0
    @Environment(\.dismiss) var dismiss
    @Environment(\.openWindow) var openWindow

    private var workSet: TimeSet {
        TimeSet(
            title: "Work",
            icon: "briefcase",
            hours: workHours,
            minutes: workMins,
            seconds: workSeconds
        )
    }

    private var breakSet: TimeSet {
        TimeSet(
            title: "Break",
            icon: "figure.walk",
            hours: breakHours,
            minutes: breakMins,
            seconds: breakSeconds
        )
    }

    private var resolvedSelectedSet: TimeSet? {
        guard let selectedSet else { return nil }
        switch selectedSet.title {
        case workSet.title:
            return workSet
        case breakSet.title:
            return breakSet
        default:
            return selectedSet
        }
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                if (selectedSet?.title == workSet.title || !timeObject.isRunning) {
                        TimeCell(selectedSet: $selectedSet, set: workSet)
                        .onAppear {
                            if selectedSet == nil {
                                selectedSet = workSet
                            }
                        }
                }
                    
                if (selectedSet?.title == breakSet.title || !timeObject.isRunning) {
                    TimeCell(selectedSet: $selectedSet, set: breakSet)
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
                                if let ref = resolvedSelectedSet {
                                    selectedSet = ref
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
            .onChange(of: workHours) {
                refreshSelectedSetIfIdle()
            }
            .onChange(of: workMins) {
                refreshSelectedSetIfIdle()
            }
            .onChange(of: workSeconds) {
                refreshSelectedSetIfIdle()
            }
            .onChange(of: breakHours) {
                refreshSelectedSetIfIdle()
            }
            .onChange(of: breakMins) {
                refreshSelectedSetIfIdle()
            }
            .onChange(of: breakSeconds) {
                refreshSelectedSetIfIdle()
            }
            .onChange(of: timeObject.reference.title) {
                if timeObject.reference.title == workSet.title {
                    selectedSet = workSet
                } else if timeObject.reference.title == breakSet.title {
                    selectedSet = breakSet
                }
            }
        }
      
    }

    private func refreshSelectedSetIfIdle() {
        guard !timeObject.didStart else { return }
        selectedSet = resolvedSelectedSet
    }
}
