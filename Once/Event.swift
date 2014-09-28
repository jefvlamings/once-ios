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
    var name: String?
    
    /**
        X coordinate
    */
    var x: CGFloat?
    
    /**
        Y coordinate
    */
    var y: CGFloat?
    
    /**
        Initializer
    */
    init() {
    }
    
    /**
        Set JSON
    */
    func setJSON(json: AnyObject) {
        let jsonDict = JSONValue(json)
        var name:NSString? = jsonDict[0].string
        let coorX = jsonDict[1]["x"].number
        let coorY = jsonDict[1]["y"].number
        if coorX != nil && coorY != nil && name == "mouse1" {
            self.x = CGFloat(coorX!)
            self.y = CGFloat(coorY!)
            self.name = name
        }
    }
    
}