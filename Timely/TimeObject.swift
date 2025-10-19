//
//  TimeObject.swift
//  Timely
//
//  Created by Omar Abu Sharar on 10/19/25.
//

import Foundation
import Combine
import SwiftUI


@Observable
final class TimeObject {
    var remaining: Int
    
    var hours: Int {
        return remaining / 3600
    }
    var minutes: Int {
        return (remaining % 3600) / 60
    }
    var seconds: Int {
        return remaining % 60
    }
    var reference: TimeSet
    var referenceTime: Int {
        return reference.hours * 3600 + reference.minutes * 60 + reference.seconds
    }
    var isRunning: Bool = false
    var didStart: Bool {
        return remaining < referenceTime
    }
    var isCompleted: Bool {
        return remaining == 0
    }
    // any cancellable lets us have a timer when needed
    private var timer: AnyCancellable?
    
    func startTimer() {
        // ensures no duplicate timers
        timer?.cancel()
        isRunning = true
        timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect().sink { [weak self] _ in
            guard let self = self else { return }
            if remaining > 0 {
                remaining -= 1
            }
            print("Timer tick: \(self.hours):\(self.minutes):\(self.seconds)")
        }
    }
    
  
    
    func pauseTimer() {
        timer?.cancel()
        timer = nil
        isRunning = false
    }
    
    func stopTimer() {
        remaining = referenceTime
        pauseTimer()
    }
    
    init(reference: TimeSet) {
        self.reference = reference
        self.remaining = reference.hours * 3600 + reference.minutes * 60 + reference.seconds
    }
}
