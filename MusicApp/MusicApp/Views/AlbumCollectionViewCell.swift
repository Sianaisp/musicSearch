//
//  AlbumCollectionViewCell.swift
//  MusicApp
//
//  Created by Anais Plancoulaine on 04.12.21.
//

import Foundation
import UIKit

final class AlbumCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var albumCover: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var artistsLabel: UILabel!

    func configure(albumTitle: String, albumImage: UIImage, artists: String) {
        albumTitleLabel.text = albumTitle
        albumCover.image = albumImage
        artistsLabel.text = artists
    }
}
