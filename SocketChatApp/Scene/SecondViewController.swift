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
        button.setTitle(
            "Send",
            for: .normal
        )
        button.setTitleColor(
            .black,
            for: .normal
        )
        button.setTitleColor(
            .blue,
            for: .highlighted
        )
        button.addTarget(
            self,
            action: #selector(sendMessage),
            for: .touchUpInside
        )
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
        [
            sendMessageButton,
            chatTableView
        ]
            .forEach{
                view.addSubview($0)
            }
    }
    
    func setLayoutConstraints() {
        sendMessageButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
        }

        chatTableView.snp.makeConstraints {
            $0.top.equalTo(sendMessageButton.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}


extension SecondViewController: UITableViewDelegate {
    
}


extension SecondViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return chats.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = chats[indexPath.row].message.msg
        return cell
    }
    
    
}


private extension SecondViewController {
    func receiveMessage() {
        self.socket.on("sise") { [weak self] dataArray, ack in
            let data = dataArray[0] as! NSDictionary
            
            print(data)

        }
    }
    
    @objc func sendMessage() {
        self.socket.emit("sise", ["code":"000000"])
    }
}
