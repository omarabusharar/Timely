//
//  Timer.swift
//  Timely
//
//  Created by Omar Abu Sharar on 10/19/25.
//

import Foundation

class TimeSet {
    var title: String
    var icon: String
    var hours: Int
    var minutes: Int
    var seconds: Int
    
    static func ==(lhs: TimeSet, rhs: TimeSet) -> Bool {
        return lhs.title == rhs.title
    }
    
    init(title: String, icon: String, hours: Int, minutes: Int, seconds: Int) {
        self.title = title
        self.icon = icon
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
    
    static func initializeDefaults(for section: String, values: (Int, Int, Int)) {
        UserDefaults.standard.set(values.0, forKey: "\(section)Hours")
        UserDefaults.standard.set(values.1, forKey: "\(section)Minutes")
        UserDefaults.standard.set(values.2, forKey: "\(section)Seconds")
    }
    
    static var work: TimeSet {
        var hours: Int {
            UserDefaults.standard.integer(forKey: "workHours")
        }
        var minutes: Int {
            UserDefaults.standard.integer(forKey: "workMinutes")
        }
        var seconds: Int {
            UserDefaults.standard.integer(forKey: "workSeconds")
        }
        
        return TimeSet(title: "Work", icon: "briefcase", hours: hours, minutes: minutes, seconds: seconds)
    }
    
    // cant use break, therefore use recess synonym
    static var recess: TimeSet {
        var hours: Int {
            UserDefaults.standard.integer(forKey: "breakHours")
        }
        var minutes: Int {
            UserDefaults.standard.integer(forKey: "breakMinutes")
        }
        var seconds: Int {
            UserDefaults.standard.integer(forKey: "breakSeconds")
        }
        
        return TimeSet(title: "Break", icon: "figure.walk", hours: hours, minutes: minutes, seconds: seconds)
    }
}
