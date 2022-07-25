//
//  ConnectViewController.swift
//  SocketChatApp
//
//  Created by David Yoon on 2022/01/02.
//

import UIKit

class ConnectViewController: UIViewController {
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Message to send to server"
        return textField
    }()
    
    private lazy var connectButton: UIButton = {
        let button = UIButton()
        button.setTitle("Connect", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.addTarget(self, action: #selector(tapConnectButton(_:)), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var disconnectButton: UIButton = {
        let button = UIButton()
        button.setTitle("Discoonect", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.addTarget(self, action: #selector(tapDisconnectButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("SendMessage", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.addTarget(self, action: #selector(tapSendMessageButton(_:)), for: .touchUpInside)
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
        [textField, connectButton, disconnectButton, sendButton]
            .forEach{
                self.view.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    
    func setLayoutConstraints() {
        self.connectButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        self.connectButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        
        self.disconnectButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        self.disconnectButton.leadingAnchor.constraint(equalTo: self.connectButton.trailingAnchor, constant: 16).isActive = true
        
        self.textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.textField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        self.sendButton.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 16).isActive = true
        self.sendButton.centerXAnchor.constraint(equalTo: self.textField.centerXAnchor).isActive = true
    }
    
    
    func configureNavigation() {
        self.title = "ConnectionHome"
        
    }
    
    
    @objc func tapConnectButton(_ sender: UIButton) {
        SocketIOManager.shared.establishConnection()
        let secondViewController = SecondViewController()
        self.navigationController?.pushViewController(secondViewController, animated: false)
        
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
