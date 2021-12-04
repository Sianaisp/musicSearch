//
//  AlbumModel.swift
//  MusicApp
//
//  Created by Anais Plancoulaine on 04.12.21.
//

import Foundation
import UIKit

struct Artist {
    let artistName: String
    let artistImage: String?
    let artistId: Int

    static func parse(_ json: [String: Any]) -> Artist? {
        let artistName = json["name"] as? String
        let artistImage = json["picture_big"] as? String ?? ""
        let artistId = json["id"] as? Int
        return Artist(artistName: artistName ?? "",
                      artistImage: artistImage,
                      artistId: artistId ?? 0)
    }
}

struct Album {
    let albumTitle: String
    let albumCover: String?
    let albumId: Int

    static func parse(_ json: [String: Any]) -> Album? {
        let albumTitle = json["title"] as? String
        let albumCover = json["cover_big"] as? String ?? ""
        let albumId = json["id"] as? Int
        return Album(albumTitle: albumTitle ?? "", albumCover: albumCover, albumId: albumId ?? 0)
    }
}

struct Track {
    let trackTitle: String
    let trackNumber: Int
    let trackDuration: Int
    let trackId: Int

    static func parse(_ json: [String: Any]) -> Track? {
        let trackTitle = json["title"] as? String
        let trackNumber = json["track_position"] as? Int ?? 0
        let trackId = json["id"] as? Int
        let trackDuration = json["duration"] as? Int
        return Track(trackTitle: trackTitle ?? "", trackNumber: trackNumber, trackDuration: trackDuration ?? 0, trackId: trackId ?? 0)
    }
}
