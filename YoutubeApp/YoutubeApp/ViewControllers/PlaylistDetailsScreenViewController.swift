//
//  PlaylistDetailsScreenViewController.swift
//  YoutubeApp
//
//  Created by Roshni Varghese on 2020-10-25.
//

import UIKit
import GoogleAPIClientForREST
import SDWebImage

protocol PlaylistDetailsScreenViewControllerDelegate: class {
    func playlistDetailsScreenViewController(_ controller: PlaylistDetailsScreenViewController, didSelectItem videoId: String?)
}

class PlaylistDetailsScreenViewController: UIViewController {
    
    // declarations
    
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    
    private let service = GTLRYouTubeService()
    
    var playListItemArray: [GTLRYouTube_PlaylistItem]?
    var videoId: String?
    weak var delegate: PlaylistDetailsScreenViewControllerDelegate?
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        setupTableView()
    }
    
    lazy var titleView: UILabel = {
        let label = UILabel()
        label.text = "Playlist Detail"
        label.font = UIFont(name: "BwModelicaSS01-Medium", size: 22)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let width = label.intrinsicContentSize.width
        label.frame = CGRect(x: 0, y: 0, width: width, height: 25)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = nil
        navigationItem.titleView = titleView
        navigationController?.navigationBar.tintColor = .white
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(PlaylistItemDetailTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // fetch detail of a single video
    
    func fetchDetails(videoId: String) -> (String, String) {
        var author = ""
        var duration = ""
        YoutubeAPI().fetchVideoDetails(videoId: videoId) { (response, error) in
            
            if let err = error {
                YoutubeAPI().showAlert(title: "Error", message: err.localizedDescription, viewController: self)
            //
            }
            if let video = response?.items, !video.isEmpty {
                author = video[0].snippet?.channelTitle ?? ""
                duration = video[0].contentDetails?.duration ?? ""
            }
        }
        return (author, duration)
    }
}

// display playlist details

extension PlaylistDetailsScreenViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playListItemArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlaylistItemDetailTableViewCell
        let url = URL(string: playListItemArray?[indexPath.row].snippet?.thumbnails?.high?.url ?? "")
        cell.thumbnailImageView.sd_setImage(with: url) { (image, error, _, _) in
            DispatchQueue.main.async {
                cell.thumbnailImageView.image = image
            }
        }
        cell.titleLabel.text = playListItemArray?[indexPath.row].snippet?.title
//        cell.authorLabel.text =  self.fetchDetails(videoId: playListItemArray?[indexPath.row].snippet?.resourceId?.videoId ?? "").0
//        cell.durationLabel.text = self.fetchDetails(videoId: playListItemArray?[indexPath.row].snippet?.resourceId?.videoId ?? "").1
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    // redirect to player view with the selected video
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.videoId = playListItemArray?[indexPath.row].snippet?.resourceId?.videoId ?? ""
        self.delegate?.playlistDetailsScreenViewController(self, didSelectItem: self.videoId)
    }
}
