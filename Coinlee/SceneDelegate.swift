//
//  SceneDelegate.swift
//  Coinlee
//
//  Created by Vladyslav Petrenko on 12/08/2023.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let viewController = UIViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}

