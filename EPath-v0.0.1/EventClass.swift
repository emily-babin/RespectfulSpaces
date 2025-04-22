//
//  EventClass.swift
//  EPath-v0.0.1
//
//  Created by Emily Babin on 2025-03-28.
//

import Foundation

class Event {
    // day month year name desc tag priority
    var year: Int
    var month: Int
    var day: Int
    var name: String
    var desc: String
    var tag: String
    var priority: Bool
    
    init (year: Int, month: Int, day: Int, name: String, desc: String, tag: String, priority: Bool) {
        self.year = year
        self.month = month
        self.day = day
        self.name = name
        self.desc = desc
        self.tag = tag
        self.priority = priority
    }
    
    init (day: Int, desc: String) {
        self.year = 2025
        self.month = 1
        self.day = day
        self.name = ""
        self.desc = desc
        self.tag = ""
        self.priority = true
    }
    
    init (day: Int, month: Int, name: String) {
        self.year = 2025
        self.month = month
        self.day = day
        self.name = name
        self.desc = ""
        self.tag = ""
        self.priority = true
    }
    
    init() {
        self.year = 2025
        self.month = 1
        self.day = 1
        self.name = ""
        self.desc = ""
        self.tag = ""
        self.priority = true
    }
}
