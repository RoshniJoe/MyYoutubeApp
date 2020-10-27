//
//  ApplicationCoordinator.swift
//  YoutubeApp
//
//  Created by Roshni Varghese on 2020-10-24.
//

import UIKit

class ApplicationCoordinator: NavigationCoordinator {
    
    private let window: UIWindow
    private let rootViewController: UINavigationController
    private var googleSignInCoordinator: GoogleSignInCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        rootViewController.navigationBar.backgroundColor = #colorLiteral(red: 0.07367884368, green: 0.2932860255, blue: 0.5300483704, alpha: 1)
        rootViewController.navigationBar.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        rootViewController.navigationBar.prefersLargeTitles = true

        googleSignInCoordinator = GoogleSignInCoordinator(presenter: rootViewController)
    }
    
    func start() {
        window.rootViewController = rootViewController
        googleSignInCoordinator?.start()
        window.makeKeyAndVisible()
    }
}
