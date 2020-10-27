//
//  SceneDelegate.swift
//  YoutubeApp
//
//  Created by Roshni Varghese on 2020-10-24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var applicationCoordinator: ApplicationCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
                
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        // setting the root view of the application
        if let currentWindow = window {
            let appCoordinator = ApplicationCoordinator(window: currentWindow)
            self.applicationCoordinator = appCoordinator
            appCoordinator.start()
        }
        
        // to make status bar color same as navigation bar
        let statusBar = UIView(frame: windowScene.statusBarManager?.statusBarFrame ?? CGRect.zero)
        statusBar.backgroundColor = #colorLiteral(red: 0.07367884368, green: 0.2932860255, blue: 0.5300483704, alpha: 1)
        self.window?.addSubview(statusBar)
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
    }
    
    
}

