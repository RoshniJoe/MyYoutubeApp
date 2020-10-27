//
//  PlaylistsScreenViewController.swift
//  YoutubeApp
//
//  Created by Roshni Varghese on 2020-10-24.
//

import UIKit
import GoogleAPIClientForREST
import GTMSessionFetcher
import SDWebImage

protocol PlaylistsScreenViewControllerDelegate: class {
    func playlistsScreenViewController(_ controller: PlaylistsScreenViewController, didSelectItem playListItem: [GTLRYouTube_PlaylistItem]?)
}

class PlaylistsScreenViewController: UIViewController {
    
    // declarations
    
    private let screenSize: CGRect = UIScreen.main.bounds
    private let cellReuseIdentifier = "collectionCell"
    
    var playList: [GTLRYouTube_Playlist]!

    weak var delegate: PlaylistsScreenViewControllerDelegate?
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        setupCollectionView()
    }
    
    lazy var titleView: UILabel = {
        let label = UILabel()
        label.text = "Public Playlists"
        label.font = UIFont(name: "BwModelicaSS01-Medium", size: 22)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let width = label.intrinsicContentSize.width
        label.frame = CGRect(x: 0, y: 0, width: width, height: 25)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationItem.title = nil
        navigationItem.titleView = titleView
    }
    
    func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.register(PublicPlayListCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

// display all user's public playlists

extension PlaylistsScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! PublicPlayListCollectionViewCell
        let url = URL(string: playList?[indexPath.row].snippet?.thumbnails?.high?.url ?? "")
        cell.thumbnailImageView.sd_setImage(with: url) { (image, error, _, _) in
            DispatchQueue.main.async {
                cell.thumbnailImageView.image = image
            }
        }
        cell.titleLabel.text = playList?[indexPath.row].snippet?.title
        cell.videoCountLabel.text = "\(playList?[indexPath.row].contentDetails?.itemCount ?? 0) videos"
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = (screenSize.width)/3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 20, left: 40, bottom: 20, right: 40)
    }
    
    // redirect to detail screen with selected playlist
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        YoutubeAPI().fetchPlaylistDetails(playListId: playList?[indexPath.row].identifier ?? "") { (response, error) in
            if let err = error {
                YoutubeAPI().showAlert(title: "Error", message: err.localizedDescription, viewController: self)
                return
            }
            if let playlistItems = response, !playlistItems.isEmpty {
                self.delegate?.playlistsScreenViewController(self, didSelectItem: playlistItems)
            }
        }
    }
}
