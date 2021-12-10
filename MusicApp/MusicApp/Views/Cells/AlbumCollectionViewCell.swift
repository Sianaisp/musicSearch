//
//  AlbumCollectionViewCell.swift
//  MusicApp
//
//  Created by Anais Plancoulaine on 04.12.21.
//

import Foundation
import UIKit

final class AlbumCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var albumCover: UIImageView!
    @IBOutlet private weak var albumTitleLabel: UILabel!
    @IBOutlet private weak var artistsLabel: UILabel!

    func configure(albumTitle: String,
                   albumImage: String,
                   artists: String) {
        albumTitleLabel.text = albumTitle
        artistsLabel.text = artists
        albumCover.setImage(from: albumImage)
    }
}
