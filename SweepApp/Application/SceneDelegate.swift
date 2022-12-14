//
//  SceneDelegate.swift
//  SweepApp
//
//  Created by Nicolas Barbosa on 09/09/22.
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
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        let alreadyLaunched = UserDefaults.standard.bool(forKey: "AppLauch")

        if !alreadyLaunched {
            window?.rootViewController = UINavigationController(rootViewController: InitialViewController())
            window?.makeKeyAndVisible()
            UserDefaults.standard.set(true, forKey: "AppLauch")
            UserDefaults.standard.synchronize()
        } else {
            window?.rootViewController = UINavigationController(rootViewController: ViewController())
            window?.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

}
