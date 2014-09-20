//
//  GameScene.swift
//  elastix
//
//  Created by Jef Vlamings on 18/08/14.
//  Copyright (c) 2014 Jef Vlamings. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var sprites : [SKSpriteNode] = []
    
    func placeFingerPrints(touches: NSSet) {
        removeChildrenInArray(sprites)
        
        /* Called when a touch moves */
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            var sprite = SKSpriteNode(imageNamed:"Spaceship")
            sprite.xScale = 0.05
            sprite.yScale = 0.05
            sprite.position = location
            addChild(sprite)
            sprites.append(sprite)
            
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        placeFingerPrints(touches)
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        removeChildrenInArray(sprites)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent!) {
        placeFingerPrints(touches)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
