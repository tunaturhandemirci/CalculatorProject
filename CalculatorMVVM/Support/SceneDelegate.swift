//
//  SceneDelegate.swift
//  CalculatorMVVM
//
//  Created by Tuna Demirci on 26.08.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let startViewController = MainViewController()
        window.rootViewController = startViewController
        self.window = window
        window.makeKeyAndVisible()
    }
}

