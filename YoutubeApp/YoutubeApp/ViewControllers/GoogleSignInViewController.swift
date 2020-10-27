//
//  GoogleSignInViewController.swift
//  YoutubeApp
//
//  Created by Roshni Varghese on 2020-10-24.
//

import UIKit
import GoogleSignIn
import GoogleAPIClientForREST
import GTMSessionFetcher

protocol GoogleSignInViewControllerDelegate: class {
    func googleSignViewControllerLoggedIn(_ controller: GoogleSignInViewController, playList: [GTLRYouTube_Playlist]?)
}

class GoogleSignInViewController: UIViewController {
    
    // declarations
    
    private let scopes = [kGTLRAuthScopeYouTubeReadonly]
    private let googleSignInSharedInstance = GIDSignIn.sharedInstance()
    private let youTubeAPI = YoutubeAPI()
    weak var delegate: GoogleSignInViewControllerDelegate?
    
    // connections
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        googleSignInSharedInstance?.presentingViewController = self
        
        //        Automatically sign in the user.
        //        googleSignInSharedInstance?.restorePreviousSignIn()
        
        googleSignInSharedInstance?.delegate = self
        googleSignInSharedInstance?.scopes = scopes
        
    }
}

//MARK: - delegate after sign-in flow is completed

extension GoogleSignInViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!,
              didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }else {
            self.signInButton.isHidden = true
            
            //fetch all user's public playlists from Youtube
            youTubeAPI.service.authorizer = user.authentication.fetcherAuthorizer()
            youTubeAPI.fetchPlaylist() { (response, error) in
                if let err = error {
                    self.youTubeAPI.showAlert(title: "Error", message: err.localizedDescription, viewController: self)
                    return
                }
                if let playlist = response, !playlist.isEmpty {
                    self.delegate?.googleSignViewControllerLoggedIn(self, playList: playlist)
                }
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!,
              didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}


