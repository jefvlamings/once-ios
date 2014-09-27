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
        Particle
    */
    var particle: SKEmitterNode!
    
    
    /**
        Initializer
    */
    init() {
        self.createParticle()
    }
    
    /**
        Creates an SKEmitterNode
    */
    func createParticle() {
        
        self.particle = SKEmitterNode(fileNamed: "MyParticle.sks")
        self.particle.name = "sparkEmmitter"
        self.particle.zPosition = 1
        // self.particle.targetNode = self
        self.particle.particleLifetime = 1
        
    }
    
    /**
        Update the postion of the particle
    */
    func setPosition(location: CGPoint) {
        self.particle.position = location
    }
    
}