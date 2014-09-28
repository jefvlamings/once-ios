//
//  Hand.swift
//  Once
//
//  Created by Jef Vlamings on 28/09/14.
//  Copyright (c) 2014 Jef Vlamings. All rights reserved.
//

import Spritekit

class Hand {

    /**
        Fingers
    */
    var fingers: [Finger] = []
    
    /**
        Scene
    */
    var scene: SKScene!
    
    /**
        Id
    */
    var id: Int
    
    /**
        Initializer
    */
    init(id: Int, scene: SKScene) {
        self.id = id
        self.scene = scene
    }
    
    /**
        Add Finger
    */
    func addFinger(location: CGPoint) -> Finger {
        let id = self.getNewFingerId()
        let finger = Finger(id: id, scene: self.scene)
        self.fingers.append(finger)
        return finger
    }
    
    /**
        Get New Finger Id
    */
    func getNewFingerId() -> Int {
        if(self.fingers.isEmpty) {
            return 0
        }
        else {
            let highestFingerId = self.getHighestFingerId()
            return highestFingerId + 1
        }
    }
    
    /**
        Get Highest Finger Id
    */
    func getHighestFingerId() -> Int {
        var highestId = 0
        for finger in self.fingers {
            if finger.id > highestId {
                highestId = finger.id
            }
        }
        return highestId
    }
    
    /**
        Move Finger
    */
    func moveFinger(id: Int, location: CGPoint) {
        if let finger = self.getFingerById(id) {
            finger.setPosition(location)
        }
    }
    
    /**
        Remove Finger
    */
    func removeFinger(id: Int) {
        var index = 0
        for finger in self.fingers {
            if finger.id == id {
                finger.destroy()
                self.fingers.removeAtIndex(index)
            }
            index++
        }
    }
    
    /**
        Get Finger By Id
    */
    func getFingerById(id: Int) -> Finger? {
        var fingerToBeFound: Finger?
        for finger in self.fingers {
            if finger.id == id {
                fingerToBeFound = finger
            }
        }
        return fingerToBeFound
    }
    
    /**
        Get Finger By Touch
    */
    func getFingerByTouch(touch: UITouch) -> Finger? {
        var fingerToBeFound: Finger?
        for finger in self.fingers {
            if finger.touch == touch {
                fingerToBeFound = finger
            }
        }
        return fingerToBeFound
    }
    
}








