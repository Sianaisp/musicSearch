//
//  AlbumCollectionHeader.swift
//  MusicApp
//
//  Created by Anais Plancoulaine on 08.12.21.
//
import UIKit
import Foundation

class AlbumHeaderView: UICollectionReusableView {
    @IBOutlet private weak var artistLabel: UILabel!
    @IBOutlet private weak var albumsLabel: UILabel!

    func configure(artist: String, hasSeveralAlbums: Bool) {
        artistLabel.text = artist
        albumsLabel.text = hasSeveralAlbums ? "Albums" : "Album"
    }
}
