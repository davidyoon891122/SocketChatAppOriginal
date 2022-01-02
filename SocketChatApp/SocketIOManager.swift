//
//  SocketManager.swift
//  SocketChatApp
//
//  Created by David Yoon on 2022/01/02.
//

import UIKit
import SocketIO

class SocketIOManager: NSObject {
    static let shared = SocketIOManager()
    var manager = SocketManager(socketURL: URL(string: "http://localhost:9000")!, config: [.log(true), .compress])
    var socket: SocketIOClient
    
    override init() {
        
        self.socket = self.manager.socket(forNamespace: "/test")
        
        socket.on("test") { dataArray, ack in
            dataArray.forEach{
                print("dataArray:\($0)")
            }
        }
        super.init()
    }
    
    func establishConnection() {
        self.socket.connect()
    }
    
    func closeConnection() {
        self.socket.disconnect()
    }
    
    func sendMessage(message: String, nickName: String) {
        socket.emit("event", ["message": "This is a test message"])
        socket.emit("event1", [["name": "ns"], ["email": "@naver.com"]])
        socket.emit("event2", ["name":"ns", "email": "@naver.com"])
        socket.emit("msg", ["nick":nickName, "msg": message])
    }
}
