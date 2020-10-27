//
//  PlaylistsScreenCoordinator.swift
//  YoutubeApp
//
//  Created by Roshni Varghese on 2020-10-24.
//

import UIKit
import GoogleAPIClientForREST

class PlaylistsScreenCoordinator: NavigationCoordinator {
    
    private let presenter: UINavigationController
    private var playlistDetailsScreenCoordinator: PlaylistDetailsScreenCoordinator?
    private var playlistsScreenViewController: PlaylistsScreenViewController?
    private let playList: [GTLRYouTube_Playlist]?
    
    init(presenter: UINavigationController, playList: [GTLRYouTube_Playlist]) {
        self.presenter = presenter
        self.playList = playList
    }
    
    // show PlaylistsScreenViewController
    
    func start() {
        if let playList = playList{
            let playlistsScreenViewController = PlaylistsScreenViewController()
            playlistsScreenViewController.playList = playList
            playlistsScreenViewController.delegate = self
            self.playlistsScreenViewController = playlistsScreenViewController
            presenter.pushViewController(playlistsScreenViewController, animated: true)
        }
    }
}

// Navigate from Playlist Screen to Playlist Detail Screen

extension PlaylistsScreenCoordinator: PlaylistsScreenViewControllerDelegate {
    func playlistsScreenViewController(_ controller: PlaylistsScreenViewController, didSelectItem playListItem: [GTLRYouTube_PlaylistItem]?) {
        if let playListItem = playListItem{
            let playlistDetailsScreenCoordinator = PlaylistDetailsScreenCoordinator(presenter: presenter, playList: playListItem)
            self.playlistDetailsScreenCoordinator = playlistDetailsScreenCoordinator
            playlistDetailsScreenCoordinator.start()
        }
    }
}
