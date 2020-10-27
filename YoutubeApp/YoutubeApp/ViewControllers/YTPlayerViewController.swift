//
//  YTPlayerViewController.swift
//  YoutubeApp
//
//  Created by Roshni Varghese on 2020-10-25.
//

import UIKit
import GoogleAPIClientForREST
import youtube_ios_player_helper

class YTPlayerViewController: UIViewController {
    
    // connections
    
    @IBOutlet weak var playerView: YTPlayerView!
    
    // declarations
    
    var videoId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let video = videoId {
            playerView.load(withVideoId: video, playerVars: ["playsinline":"1"])
        }
    }
}

/*      Player Variables
 ["playsinline":"0", // 1 in view or 0 fullscreen
 "autoplay":"1", // Auto-play the video on load
 "modestbranding":"1", // without button of youtube and giat branding
 "rel":"0",
 "controls":"0", // Show pause/play buttons in player
 "fs":"1", // Hide the full screen button
 "origin":"https://www.example.com",
 "cc_load_policy":"0", // Hide closed captions
 "iv_load_policy":"3", // Hide the Video Annotations
 "loop":"0",
 "version":"3",
 "playlist":"",
 "autohide":"0", // Hide video controls when playing
 "showinfo":"0"] // show related videos at the end
 */
