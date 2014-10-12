//
//  Api.swift
//  Once
//
//  Created by Jef Vlamings on 28/09/14.
//  Copyright (c) 2014 Jef Vlamings. All rights reserved.
//

class Api: NSObject, SocketIODelegate {
    
    /**
        Socket
    */
    let socket: SocketIO!
    
    /**
        Delegate
    */
    var delegate: ApiDelegate!
    
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
        let json: AnyObject! = packet.dataAsJSON()
        let jsonDict = JSONValue(json)
        var name:NSString? = jsonDict[0].string
        let coorX = jsonDict[1]["x"].number
        let coorY = jsonDict[1]["y"].number
        if coorX != nil && coorY != nil && name == "mouse1" {
            let event = Event(name: name!, x: Float(coorX!), y: Float(coorY!))
            self.delegate.eventReceived(event)
        }
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
        Send Event
    */
    func sendEvent(event: Event) {
        socket.sendEvent(event.name, withData: event.getData())
    }
    
    /**
    Initializer
    */
    required override init() {
        super.init()
        self.socket = SocketIO()
        self.socket.delegate = self
        self.socket.connectToHost("192.168.0.226", onPort:6969)
    }
    
}
