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
    var manager = SocketManager(
        socketURL: URL(string: "http://localhost:9000")!,
        config: [.log(false), .compress]
    )
    var socket: SocketIOClient
    
    override init() {
        self.socket = self.manager.socket(forNamespace: "/test")
        super.init()
    }
    
    func establishConnection() {
        self.socket.connect()
    }
    
    func closeConnection() {
        self.socket.disconnect()
    }
    
    func sendMessage(message: String, nickName: String) {
        socket.emit("test", ["nick":nickName, "msg": message])
    }
}
