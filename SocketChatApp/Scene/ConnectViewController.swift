//
//  ConnectViewController.swift
//  SocketChatApp
//
//  Created by David Yoon on 2022/01/02.
//

import UIKit
import SnapKit

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.addSubviews()
        self.setLayoutConstraints()
        self.configureNavigation()
    }
    
    
    func addSubviews() {
        [
            textField,
            connectButton,
            disconnectButton,
            sendButton
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

        textField.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        sendButton.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    
    func configureNavigation() {
        self.title = "ConnectionHome"
    }
    
    
    @objc func tapConnectButton(_ sender: UIButton) {
        SocketIOManager.shared.establishConnection()
//        let secondViewController = SecondViewController()
//        self.navigationController?.pushViewController(secondViewController, animated: false)
//        
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
