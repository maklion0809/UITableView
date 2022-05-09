//
//  SceneDelegate.swift
//  Task6UITableView
//
//  Created by Tymofii (Work) on 04.10.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = TableViewController()
        window.makeKeyAndVisible()
        
        self.window = window
    }
}

