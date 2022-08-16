//
//  SceneDelegate.swift
//  SmartNews
//
//  Created by Вадим Лавор on 29.07.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        window?.rootViewController = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()
        window?.makeKeyAndVisible()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            if UserDefaults.standard.data(forKey: "headings") != nil {
                self.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBar")
            } else {
                self.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "topic")
            }
        }
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
}
