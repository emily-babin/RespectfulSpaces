//
//  ScenariosStruct.swift
//  EPath-v0.0.1
//
//  Created by Carlos Pillas on 2025-03-04.
//

import Foundation

class Scenarios {
    
    var title: String
    var tag: String
    var imageName: String
    var description: String
    var content: String
    var commonResponse: String
    var facts:String
    
    
    // Initialize the class with a custom initializer
    init(title: String, tag: String, imageName: String, description: String, content:String, commonResponse:String, facts:String) {
        
        self.title = title
        self.tag = tag
        self.imageName = imageName
        self.description = description
        self.content = content
        self.commonResponse = commonResponse
        self.facts = facts
    }
    
    init() {
        self.title = ""
        self.tag = ""
        self.imageName = ""
        self.description = ""
        self.content = ""
        self.commonResponse = ""
        self.facts = ""
    }
}
