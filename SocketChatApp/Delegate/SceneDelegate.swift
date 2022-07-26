//
//  SceneDelegate.swift
//  SocketChatApp
//
//  Created by David Yoon on 2022/01/02.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.backgroundColor = .systemBackground
        let mainViewController = ChatViewController()
        self.window?.rootViewController = UINavigationController(rootViewController: mainViewController)
        self.window?.makeKeyAndVisible()
        
        
    }
}

