//
//  YoutubeAPI.swift
//  YoutubeApp
//
//  Created by Roshni Varghese on 2020-10-26.
//

import GoogleAPIClientForREST
import GTMSessionFetcher
import UIKit

// No separate model classes created, since the APIClient provides with all the necessary response objects, if it was to yse the url then codable classes may be included for easy data access.

final class YoutubeAPI {
    
    public let service = GTLRYouTubeService()
    
    // recursively fetching all user's public playlists from Youtube
    
    var fullPlaylist = [GTLRYouTube_Playlist]()
    
    func fetchPlaylist(pageToken: String? = nil,
                       _ completionHandler: @escaping (_ object: [GTLRYouTube_Playlist]?,
                                                       _ callbackError: Error?) -> Void) {
        
        let query = GTLRYouTubeQuery_PlaylistsList(pathURITemplate: "youtube/v3/playlists", httpMethod: nil, pathParameterNames: nil)
        query.mine = true
        query.part = ["snippet", "contentDetails"]
        query.pageToken = pageToken
        
        service.executeQuery(query) { (_, response, error) in
            self.fullPlaylist += (response as? GTLRYouTube_PlaylistListResponse)?.items ?? []
            if let nextPageToken = (response as? GTLRYouTube_PlaylistListResponse)?.nextPageToken{
                self.fetchPlaylist(pageToken: nextPageToken) { (response, error) in
                    completionHandler(self.fullPlaylist, error)
                }
            }else{
                completionHandler(self.fullPlaylist, error)
            }
        }
    }
    
    //recursively fetching playlist details and all videos in it
    
    var fullPlaylistItems = [GTLRYouTube_PlaylistItem]()
    
    func fetchPlaylistDetails(playListId: String,
                              pageToken: String? = nil,
                              _ completionHandler: @escaping (_ object: [GTLRYouTube_PlaylistItem]?,
                                                              _ callbackError: Error?) -> Void) {
        
        let query = GTLRYouTubeQuery_PlaylistItemsList(pathURITemplate: "youtube/v3/playlistItems?key=AIzaSyAwNseKr8a0dsCSG5drBhgGPpkR_OBmOmQ&playlistId=\(playListId)&pageToken=\(pageToken ?? "")", httpMethod: nil, pathParameterNames: nil)
        query.part = ["snippet", "contentDetails"]
        
        service.executeQuery(query) { (_, response, error) in
            self.fullPlaylistItems += (response as? GTLRYouTube_PlaylistItemListResponse)?.items ?? []
            if let nextPageToken = (response as? GTLRYouTube_PlaylistItemListResponse)?.nextPageToken{
                self.fetchPlaylistDetails(playListId: playListId, pageToken: nextPageToken, { (response, error) in
                    completionHandler(self.fullPlaylistItems, error)
                })
            }else{
                completionHandler(self.fullPlaylistItems, error)
            }
        }
    }
    
    // fetch details of a selected video
    
    func fetchVideoDetails(videoId: String, _ completionHandler: @escaping (_ object: GTLRYouTube_VideoListResponse?, _ callbackError: Error?) -> Void) {
        let query = GTLRYouTubeQuery_VideosList(pathURITemplate: "youtube/v3/videos?key=AIzaSyAwNseKr8a0dsCSG5drBhgGPpkR_OBmOmQ&id=\(videoId)", httpMethod: nil, pathParameterNames: nil)
        query.part = ["snippet", "contentDetails", "player"]
        service.executeQuery(query) { (_, response, error) in
            completionHandler(response as? GTLRYouTube_VideoListResponse, error)
        }
    }
    
    // Helper for showing an alert
    
    func showAlert(title : String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertAction.Style.default,
            handler: nil
        )
        alert.addAction(ok)
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
