//
//  PlaylistDetailsScreenCoordinator.swift
//  YoutubeApp
//
//  Created by Roshni Varghese on 2020-10-25.
//

import UIKit
import GoogleAPIClientForREST

class PlaylistDetailsScreenCoordinator: NavigationCoordinator {
    
    private let presenter: UINavigationController
    private var ytPlayerViewCoordinator: YTPlayerViewCoordinator?
    private var playlistDetailsScreenViewController: PlaylistDetailsScreenViewController?
    private let playList: [GTLRYouTube_PlaylistItem]?
    
    
    init(presenter: UINavigationController, playList: [GTLRYouTube_PlaylistItem]) {
        self.presenter = presenter
        self.playList = playList
    }
    
    // show PlaylistDetailsScreenViewController
    
    func start() {
        if let playList = playList{
            let playlistDetailsScreenViewController = PlaylistDetailsScreenViewController()
            playlistDetailsScreenViewController.playListItemArray = playList
            playlistDetailsScreenViewController.delegate = self
            self.playlistDetailsScreenViewController = playlistDetailsScreenViewController
            presenter.pushViewController(playlistDetailsScreenViewController, animated: true)
        }
    }
}

// Navigate from Playlist Detail Screen to Youtube Player

extension PlaylistDetailsScreenCoordinator: PlaylistDetailsScreenViewControllerDelegate {
    func playlistDetailsScreenViewController(_ controller: PlaylistDetailsScreenViewController, didSelectItem videoId: String?) {
        if let videoId = videoId{
            let ytPlayerViewCoordinator = YTPlayerViewCoordinator(presenter: presenter, videoId: videoId)
            self.ytPlayerViewCoordinator = ytPlayerViewCoordinator
            ytPlayerViewCoordinator.start()
        }
    }
}

