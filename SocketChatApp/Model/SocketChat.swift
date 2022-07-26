//
//  SocketChat.swift
//  SocketChatApp
//
//  Created by David Yoon on 2022/01/02.
//

import Foundation

struct SocketChat: Codable {
    var type: Int = -1
    var message: Info = Info()
}

struct Info: Codable {
    var msg: String = ""
    var nick: String = ""
}

