//
//  SecondViewController.swift
//  SocketChatApp
//
//  Created by David Yoon on 2022/01/02.
//

import UIKit
import SocketIO

class SecondViewController: UIViewController {

    private lazy var chatTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "cell"
        )
        return tableView
    }()
    
    private lazy var sendMessageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return button
    }()
    
    private var socket: SocketIOClient!
    private var chats: [SocketChat] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubviews()
        self.setLayoutConstraints()
        self.socket = SocketIOManager.shared.socket
        self.receiveMessage()
    }
    
    
    func addSubviews() {
        [self.sendMessageButton, self.chatTableView]
            .forEach{
                self.view.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    func setLayoutConstraints() {
        self.sendMessageButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.sendMessageButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        
        self.chatTableView.topAnchor.constraint(equalTo: self.sendMessageButton.bottomAnchor).isActive = true
        self.chatTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.chatTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.chatTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
}


extension SecondViewController: UITableViewDelegate {
    
}


extension SecondViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = chats[indexPath.row].message
        return cell
    }
    
    
}


private extension SecondViewController {
    func receiveMessage() {
        self.socket.on("sise") { [weak self] dataArray, ack in
            let data = dataArray[0] as! NSDictionary
            
            print(data)
            
//            let chatType = data["type"] as! Int
//            let chatMessage = data["message"] as! [String:Any]
//            let chat = SocketChat(type: chatType, message: chatMessage["msg"] as! String)
//            print("data from server : \(chat)")
//            self?.chats.append(chat)
//
//            self?.chatTableView.reloadData()
            
        }
    }
    
    @objc func sendMessage() {
        self.socket.emit("sise", ["code":"000000"])
    }
}
