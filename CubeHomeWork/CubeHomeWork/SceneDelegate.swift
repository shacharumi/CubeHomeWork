//
//  SceneDelegate.swift
//  CubeHomeWork
//
//  Created by shachar on 2025/4/2.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene = (scene as? UIWindowScene) else { return }

            let tabBarController = UITabBarController()
            let friendVC = ViewController()
            let moneyVC = spaceController()
            let recordVC = spaceController()
            let koVC = spaceController()
            let settingVC = spaceController()

            let friendNaVi = UINavigationController(rootViewController: friendVC)
            let moneyNaVi = UINavigationController(rootViewController: moneyVC)
            let koNaVi = UINavigationController(rootViewController: koVC)
            let recordNaVi = UINavigationController(rootViewController: recordVC)
            let settingNaVi = UINavigationController(rootViewController: settingVC)

        friendNaVi.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "friendIcon"), selectedImage: UIImage(named: "friendIcon"))
        moneyNaVi.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "moneyIcon"), selectedImage: UIImage(named: "moneyIcon"))
        koNaVi.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "koIcon"), selectedImage: UIImage(named: "koIcon"))
        recordNaVi.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "recordIcon"), selectedImage: UIImage(named: "recordIcon"))
        settingNaVi.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "settingIcon"), selectedImage: UIImage(named: "settingIcon"))

            tabBarController.viewControllers = [moneyNaVi, friendNaVi, koNaVi, recordNaVi, settingNaVi]

            window = UIWindow(windowScene: windowScene)
            window?.rootViewController = tabBarController
            window?.makeKeyAndVisible()
        }

    class spaceController: UIViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .lightGray
        }
    }
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

