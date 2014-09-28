//
//  Api.swift
//  Once
//
//  Created by Jef Vlamings on 28/09/14.
//  Copyright (c) 2014 Jef Vlamings. All rights reserved.
//

import Spritekit

class Api: NSObject, SocketIODelegate {
    
    /**
        Socket
    */
    let socket: SocketIO!
    
    /**
        Scene
    */
    let scene: SKScene!
    
    /**
        Initializer
    */
    required init(scene: SKScene) {
        super.init()
        self.scene = scene
        self.socket = SocketIO(delegate: self)
        self.socket.connectToHost("192.168.0.226", onPort:6969)
    }
    
    /**
        Connection started
    */
    func socketIODidConnect(socket: SocketIO!) {
        println("1")
    }
    
    /**
        Connection stopped
    */
    func socketIODidDisconnect(socket: SocketIO!, disconnectedWithError: NSError) {
        println("2")
    }
    
    /**
        Message received
    */
    func socketIO(socket: SocketIO!, didReceiveMessage packet: SocketIOPacket) {
        println("3")
    }
    
    /**
        JSON received
    */
    func socketIO(socket: SocketIO!, didReceiveJSON packet: SocketIOPacket) {
        println("4")
    }
    
    /**
        Event received
    */
    func socketIO(socket: SocketIO!, didReceiveEvent packet: SocketIOPacket) {
        let event = Event()
        event.setJSON(packet.dataAsJSON())
        
        if event.name != nil {
            let screenWidth = self.scene.size.width
            let screenHeight = self.scene.size.height
            var x = event.x! * screenWidth
            var y = (1-event.y!) * screenHeight
            var location = CGPointMake(x, y)
        }
        
        // Send to gamescene ?
        
    }
    
    /**
        Message sent
    */
    func socketIO(socket: SocketIO!, didSendMessage packet: SocketIOPacket) {
        println("6")
    }
    
    /**
        Connection error
    */
    func socketIO(socket: SocketIO!, onError error: NSError) {
        println("7")
    }
    
    /**
        Push Location
    */
    func pushLocation(location: CGPoint) {
        // Pushes a given location to the socket server
        let screenWidth = self.scene.size.width
        let screenHeight = self.scene.size.height
        let x = location.x
        let y = screenHeight - location.y
        let data = ["x": x/screenWidth, "y": y/screenHeight]
        socket.sendEvent("mouse2", withData: data)
    }
    
}
