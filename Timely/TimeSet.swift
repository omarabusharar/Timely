//
//  Timer.swift
//  Timely
//
//  Created by Omar Abu Sharar on 10/19/25.
//

import SwiftData
import Foundation

@Model
class TimeSet {
    var id: UUID
    var title: String
    var icon: String
    var hours: Int
    var minutes: Int
    var seconds: Int
    
    init(id: UUID = UUID(), title: String, icon: String, hours: Int, minutes: Int, seconds: Int) {
        self.id = id
        self.title = title
        self.icon = icon
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
}
