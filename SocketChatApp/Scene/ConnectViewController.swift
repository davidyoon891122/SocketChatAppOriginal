//
//  ConnectViewController.swift
//  SocketChatApp
//
//  Created by David Yoon on 2022/01/02.
//

import UIKit
import SnapKit
import SocketIO

final class ConnectViewController: UIViewController {
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Message to send to server"
        return textField
    }()
    
    private lazy var connectButton: UIButton = {
        let button = UIButton()
        button.setTitle(
            "Connect",
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
            action: #selector(tapConnectButton),
            for: .touchUpInside
        )
        return button
    }()
    
    
    private lazy var disconnectButton: UIButton = {
        let button = UIButton()
        button.setTitle(
            "Discoonect",
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
            action: #selector(tapDisconnectButton),
            for: .touchUpInside
        )
        return button
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "cell"
        )
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle(
            "SendMessage",
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
            action: #selector(tapSendMessageButton),
            for: .touchUpInside
        )
        return button
    }()

    private var socket: SocketIOClient!
    private var myChat: [SocketChat] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.addSubviews()
        self.setLayoutConstraints()
        self.configureNavigation()

        receiveMessage()
    }
    
    
    func addSubviews() {
        [
            textField,
            connectButton,
            disconnectButton,
            sendButton,
            tableView
        ]
            .forEach{
                self.view.addSubview($0)
            }
    }
    
    
    func setLayoutConstraints() {
        connectButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(16.0)
        }

        disconnectButton.snp.makeConstraints {
            $0.top.equalTo(connectButton)
            $0.leading.equalTo(connectButton.snp.trailing).offset(8.0)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(disconnectButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(textField.snp.top)
        }

        textField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16.0)
            $0.width.equalTo(200.0)
            $0.height.equalTo(60.0)
        }

        sendButton.snp.makeConstraints {
            $0.centerY.equalTo(textField)
            $0.leading.equalTo(textField.snp.trailing).offset(4.0)
            $0.trailing.equalToSuperview().offset(-16.0)
        }
    }
    
    
    func configureNavigation() {
        self.title = "ConnectionHome"
    }
    
    
    @objc func tapConnectButton(_ sender: UIButton) {
        SocketIOManager.shared.establishConnection()
    }
    
    @objc func tapDisconnectButton(_ sender: UIButton) {
        SocketIOManager.shared.closeConnection()
    }
    
    @objc func tapSendMessageButton(_ sender: UIButton) {
        guard let message = textField.text else {
            return
        }
        
        SocketIOManager.shared.sendMessage(message: message, nickName: "davidyoon")
    }
}

extension ConnectViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return myChat.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = myChat[indexPath.row].message.msg
        return cell
    }
}

extension ConnectViewController: UITableViewDelegate {

}


private extension ConnectViewController {
    func receiveMessage() {
        socket = SocketIOManager.shared.socket
        socket.on("test") { [weak self] dataArray, ack in
            guard let self = self else { return }
            print(dataArray)
            guard let jsonData = try? JSONSerialization.data(withJSONObject: dataArray[0], options: .prettyPrinted) else { return }
            guard let receivedJOSN = try? JSONDecoder().decode(SocketChat.self, from: jsonData) else { return }

            self.myChat.append(receivedJOSN)

            let indexPath = IndexPath(row: self.myChat.count - 1, section: 0)
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
}
