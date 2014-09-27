//
//  GameScene.swift
//  elastix
//
//  Created by Jef Vlamings on 18/08/14.
//  Copyright (c) 2014 Jef Vlamings. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SocketIODelegate {
    
    
    let socket: SocketIO!
    var particle1: SKEmitterNode!
    var particle2: SKEmitterNode!
    var particles1: [SKEmitterNode] = []
    var particles2: [SKEmitterNode] = []
    
    func socketIODidConnect(socket: SocketIO!) {
        println("1")
    }
    
    func socketIODidDisconnect(socket: SocketIO!, disconnectedWithError: NSError) {
        println("2")
    }
    
    func socketIO(socket: SocketIO!, didReceiveMessage packet: SocketIOPacket) {
        println("3")
    }
    
    func socketIO(socket: SocketIO!, didReceiveJSON packet: SocketIOPacket) {
        println("4")
    }
    
    func socketIO(socket: SocketIO!, didReceiveEvent packet: SocketIOPacket) {
        
        var json: AnyObject! = packet.dataAsJSON()
        var jsonDict = JSONValue(json)
        var name:NSString? = jsonDict[0].string
        let screenWidth = self.size.width
        let screenHeight = self.size.height
        let coorX = jsonDict[1]["x"].number
        let coorY = jsonDict[1]["y"].number
        if coorX != nil && coorY != nil && name == "mouse1" {
            var coorX = jsonDict[1]["x"].number as CGFloat
            var coorY = jsonDict[1]["y"].number as CGFloat
            var x = coorX*screenWidth
            var y = (1-coorY) * screenHeight
            var location = CGPointMake(x, y)
            if particles2.isEmpty {
                addParticle(2)
            }
            else {
                updateParticle(2, location: location)
            }
            
        }
    }
    
    func socketIO(socket: SocketIO!, didSendMessage packet: SocketIOPacket) {
        println("6")
    }
    
    func socketIO(socket: SocketIO!, onError error: NSError) {
        println("7")
    }
    
    func pushLocation(location: CGPoint) {
        // Pushes a given location to the socket server
        let screenWidth = self.size.width
        let screenHeight = self.size.height
        let x = location.x
        let y = screenHeight - location.y
        let data = ["x": x/screenWidth, "y": y/screenHeight]
        socket.sendEvent("mouse2", withData: data)
    }
    
    func updateParticle(owner: Int, location: CGPoint){
        // Adds a sprite node resembling a fingerprint to the scene
        if(owner == 1) {
            particle1.position = location
        }
        else {
            particle2.position = location
        }
    }
    
    func addParticle(owner: Int) {
        var particle = SKEmitterNode(fileNamed: "MyParticle.sks")
        particle.name = "sparkEmmitter"
        particle.zPosition = 1
        particle.targetNode = self
        particle.particleLifetime = 1
        
        if(owner == 1) {
            particle1 = particle
            particles1.append(particle1)
        }
        else {
            particle2 = particle
            particles2.append(particle2)
        }
        self.addChild(particle)
    }
    
    required init(coder aDecoder: NSCoder) {
        // Initializer
        super.init(coder: aDecoder)
        socket = SocketIO(delegate: self)
        socket.connectToHost("192.168.0.226", onPort:6969)
        self.backgroundColor = SKColor(white: CGFloat(0), alpha: CGFloat(0))
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        // Place fingerprints when the surface is touched
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            if particles1.isEmpty {
                addParticle(1)
            }
            updateParticle(1, location: location)
            pushLocation(location)
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        // Remove all fingerprints when the surface is no longer touched

    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        // Update the fingerprint location when a touch is moving
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            updateParticle(1, location: location)
            pushLocation(location)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
}
