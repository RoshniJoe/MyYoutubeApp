//
//  GoogleSignInCoordinator.swift
//  YoutubeApp
//
//  Created by Roshni Varghese on 2020-10-24.
//

import UIKit
import GoogleAPIClientForREST

class GoogleSignInCoordinator: NavigationCoordinator {
    
    private var presenter: UINavigationController
    private var playlistsScreenCoordinator: PlaylistsScreenCoordinator?
    private var googleSignInViewController: GoogleSignInViewController?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    // show GoogleSignInViewController
    
    func start() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let googleSignInViewController = mainStoryboard.instantiateViewController(withIdentifier: "GoogleSignInViewController") as! GoogleSignInViewController
        googleSignInViewController.delegate = self
        self.googleSignInViewController = googleSignInViewController
        presenter.pushViewController(googleSignInViewController, animated: true)
    }
}

// Navigate from Sign In page to Playlist Screen

extension GoogleSignInCoordinator: GoogleSignInViewControllerDelegate {
    func googleSignViewControllerLoggedIn(_ controller: GoogleSignInViewController, playList: [GTLRYouTube_Playlist]?) {
        if let playList = playList{
            let playlistsScreenCoordinator = PlaylistsScreenCoordinator(presenter: presenter, playList: playList)
            self.playlistsScreenCoordinator = playlistsScreenCoordinator
            playlistsScreenCoordinator.start()
        }
    }
}
