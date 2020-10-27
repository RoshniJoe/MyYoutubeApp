//
//  YTPlayerViewCoordinator.swift
//  YoutubeApp
//
//  Created by Roshni Varghese on 2020-10-25.
//

import UIKit
import GoogleAPIClientForREST

class YTPlayerViewCoordinator: NavigationCoordinator {
    
    private let presenter: UINavigationController
    private var ytPlayerViewController: YTPlayerViewController?
    private let videoId: String?
        
    init(presenter: UINavigationController, videoId: String?) {
        self.presenter = presenter
        self.videoId = videoId
    }
    
    // show YTPlayerViewController

    func start() {
        if let videoId = videoId{
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let ytPlayerViewController = mainStoryboard.instantiateViewController(withIdentifier: "YTPlayerViewController") as! YTPlayerViewController
            ytPlayerViewController.videoId = videoId
            self.ytPlayerViewController = ytPlayerViewController
            presenter.pushViewController(ytPlayerViewController, animated: true)
        }
    }
}

