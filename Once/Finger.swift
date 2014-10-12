//
//  Finger.swift
//  Once
//
//  Created by Jef Vlamings on 27/09/14.
//  Copyright (c) 2014 Jef Vlamings. All rights reserved.
//

import SpriteKit

class Finger {
    
    /**
        Id
    */
    var id: Int
    
    /**
        Particle
    */
    var particle: SKEmitterNode!
    
    /**
        Scene
    */
    var scene: SKScene
    
    /**
        Touch
    */
    var touch: UITouch!
    
    /**
        Position
    */
    var position: CGPoint!
    
    /**
        Initializer
    */
    init(id: Int, scene: SKScene) {
        self.id = id
        self.scene = scene
        self.createParticle()
    }
    
    /**
        Touch
    */
    func setTouch(touch: UITouch) {
        self.touch = touch
    }
    
    /**
        Creates an SKEmitterNode
    */
    func createParticle() {
        self.particle = SKEmitterNode(fileNamed: "MyParticle.sks")
        self.particle.name = "sparkEmmitter"
        self.particle.zPosition = 1
        self.particle.targetNode = self.scene
        self.particle.particleLifetime = 1
        self.scene.addChild(self.particle)
    }
    
    /**
        Update the postion of the particle
    */
    func setPosition(location: CGPoint) {
        self.position = location
        self.particle.position = location
    }
    
    /**
        Destroy
    */
    func destroy() {
        self.scene.removeChildrenInArray([self.particle])
    }
    
}