//
//  SceneDelegate.swift
//  NewCubeHomeWork
//
//  Created by shachar on 2025/4/12.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        let tabBarController = UITabBarController()
        tabBarController.tabBar.clipsToBounds = false
        tabBarController.tabBar.tintColor = UIColor(red: 236/255, green: 0/255, blue: 140/255, alpha: 1)

        let placeholderVC = UIViewController()
        placeholderVC.view.backgroundColor = .white
        let placeholderNav = UINavigationController(rootViewController: placeholderVC)

        let moneyVC = spaceController()
        let recordVC = spaceController()
        let koVC = spaceController()
        let settingVC = spaceController()

        let moneyNaVi = UINavigationController(rootViewController: moneyVC)
        let koNaVi = UINavigationController(rootViewController: koVC)
        let recordNaVi = UINavigationController(rootViewController: recordVC)
        let settingNaVi = UINavigationController(rootViewController: settingVC)

        moneyNaVi.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "moneyIcon"), selectedImage: UIImage(named: "moneyIcon"))
        placeholderNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "friendIcon"), selectedImage: UIImage(named: "friendIcon"))
        koNaVi.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "koIcon")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "koIcon")?.withRenderingMode(.alwaysOriginal))
        recordNaVi.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "recordIcon"), selectedImage: UIImage(named: "recordIcon"))
        settingNaVi.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "settingIcon"), selectedImage: UIImage(named: "settingIcon"))

        tabBarController.viewControllers = [moneyNaVi, placeholderNav, koNaVi, recordNaVi, settingNaVi]
        tabBarController.selectedIndex = 1

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.presentFriendVCSelection(on: tabBarController)
        }
    }

    private func presentFriendVCSelection(on tabBarController: UITabBarController) {
        let url: [URL] = [URL(string: "https://dimanyen.github.io/man.json")!,
                          URL(string: "https://dimanyen.github.io/friend1.json")!,
                          URL(string: "https://dimanyen.github.io/friend2.json")!,
                          URL(string: "https://dimanyen.github.io/friend3.json")!,]
        let alert = UIAlertController(title: "請選擇起始畫面", message: nil, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "1. 無好友畫面", style: .default, handler: { _ in
            let newVC = MainViewController()
            newVC.selectCase = 0
            let nav = UINavigationController(rootViewController: newVC)
            nav.tabBarItem = tabBarController.viewControllers?[1].tabBarItem
            tabBarController.viewControllers?[1] = nav
        }))

        alert.addAction(UIAlertAction(title: "2. 只有好友列表", style: .default, handler: { _ in
            let newVC = MainViewController()
            newVC.selectCase = 1
            let nav = UINavigationController(rootViewController: newVC)
            nav.tabBarItem = tabBarController.viewControllers?[1].tabBarItem
            tabBarController.viewControllers?[1] = nav
        }))

        alert.addAction(UIAlertAction(title: "3. 好友列表含邀請", style: .default, handler: { _ in
            let newVC = MainViewController()
            newVC.selectCase = 2
            let nav = UINavigationController(rootViewController: newVC)
            nav.tabBarItem = tabBarController.viewControllers?[1].tabBarItem
            tabBarController.viewControllers?[1] = nav
        }))

        tabBarController.present(alert, animated: true)
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

