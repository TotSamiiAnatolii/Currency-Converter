//
//  SceneDelegate.swift
//  Currency Converter
//
//  Created by APPLE on 16.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let converterVC = ConverterViewController()
        let converterVCNav = UINavigationController.init(rootViewController: converterVC)
        window?.rootViewController = converterVCNav
        window?.makeKeyAndVisible()
    }
}

