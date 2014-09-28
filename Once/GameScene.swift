//
//  GameScene.swift
//  elastix
//
//  Created by Jef Vlamings on 18/08/14.
//  Copyright (c) 2014 Jef Vlamings. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    /**
        API
    */
    let api: Api!
    
    /**
        My Hand
    */
    let myHand: Hand!

    /**
        Other Hand
    */
    let otherHand: Hand!
    
    /**
        Initializer
    */
    required init(coder aDecoder: NSCoder) {
        // Initializer
        super.init(coder: aDecoder)
        self.backgroundColor = SKColor(white: CGFloat(0), alpha: CGFloat(0))
        self.myHand = Hand(id: 1, scene: self)
        self.otherHand = Hand(id: 2, scene: self)
        self.api = Api(scene: self)
    }
    
    /**
        Touches Began
    */
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        // Place fingerprints when the surface is touched
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let finger = self.myHand.addFinger(location)
            finger.setTouch(touch as UITouch)
            self.api.pushLocation(location)
        }
    }
    
    /**
        Touches Ended
    */
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        // Remove all fingerprints when the surface is no longer touched
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            if let finger = self.myHand.getFingerByTouch(touch as UITouch) {
                self.myHand.removeFinger(finger.id)
            }
        }
    }
    
    /**
        Touches Moved
    */
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        // Update the fingerprint location when a touch is moving
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            if let finger = self.myHand.getFingerByTouch(touch as UITouch) {
                self.myHand.moveFinger(finger.id, location: location)
            }
            self.api.pushLocation(location)
        }
    }
    
}
