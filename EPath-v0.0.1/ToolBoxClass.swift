//
//  Untitled.swift
//  EPath-v0.0.1
//
//  Created by Carlos Pillas on 2025-03-26.
//

import Foundation

class ToolBox {
    
    var title: String
    var imageName: String
    var description: String
    var content: String

    // Initialize the class with a custom initializer
    init(title: String, imageName: String, description: String, content:String) {
        
        self.title = title
        self.imageName = imageName
        self.description = description
        self.content = content
    }
    
    init() {
        self.title = ""
        self.imageName = ""
        self.description = ""
        self.content = ""
    }
}
