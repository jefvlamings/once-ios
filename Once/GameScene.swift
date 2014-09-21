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
    var sprites : [SKSpriteNode] = []
    
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
            removeChildrenInArray(sprites)
            var coorX = jsonDict[1]["x"].number as CGFloat
            var coorY = jsonDict[1]["y"].number as CGFloat
            var x = coorX*screenWidth
            var y = (1-coorY) * screenHeight
            var location = CGPointMake(x, y)
            placeFingerPrint(location)
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
    
    func placeFingerPrint(location: CGPoint){
        // Adds a sprite node resembling a fingerprint to the scene
        let sprite = SKSpriteNode(imageNamed:"Spaceship")
        sprite.xScale = 0.05
        sprite.yScale = 0.05
        sprite.position = location
        addChild(sprite)
        sprites.append(sprite)
    }
    
    func placeFingerPrints(touches: NSSet) {
        // Place a finger print on the scene for each touch
        removeChildrenInArray(sprites)
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            pushLocation(location)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        // Initializer
        super.init(coder: aDecoder)
        socket = SocketIO(delegate: self)
        socket.connectToHost("192.168.0.226", onPort:6969)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        // Place fingerprints when the surface is touched
        placeFingerPrints(touches)
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        // Remove all fingerprints when the surface is no longer touched
        removeChildrenInArray(sprites)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        // Update the fingerprint location when a touch is moving
        placeFingerPrints(touches)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
}
