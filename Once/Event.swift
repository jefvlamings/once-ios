//
//  Event.swift
//  Once
//
//  Created by Jef Vlamings on 28/09/14.
//  Copyright (c) 2014 Jef Vlamings. All rights reserved.
//

import Spritekit

class Event {

    /**
        Name
    */
    var name: String!
    
    /**
        X coordinate
    */
    var x: Float!
    
    /**
        Y coordinate
    */
    var y: Float!
    
    /**
    
    */
    init(name: String, x: Float, y: Float) {
        self.name = name
        self.x = x
        self.y = y
    }
    
    /**
        Is Valid
    */
    func isValid() -> Bool {
        var result = true
        if(name == nil || x == nil || y == nil) {
            result = false
        }
        return result
    }
    
    /**
        Get Data
    */
    func getData() -> Dictionary<String,Float> {
        let data = ["x": Float(self.x), "y": Float(self.y)]
        return data
    }
    
}