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
    let artistImage: UIImage?
    let artistId: Int
}

struct Album {
    let albumTitle: String
    let albumCover: String?
    let albumId: Int
}

struct Track {
    let trackTitle: String
    let trackNumber: Int
    let trackDuratoon: Int
    let trackId: Int
}
