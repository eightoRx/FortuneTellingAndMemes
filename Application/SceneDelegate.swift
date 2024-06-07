//
//  SceneDelegate.swift
//  Fortune telling and memes
//
//  Created by Pavel Kostin on 05.06.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
     
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let viewController = ViewController()
        let navigatonController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigatonController
        window?.makeKeyAndVisible()
        
    }
}

