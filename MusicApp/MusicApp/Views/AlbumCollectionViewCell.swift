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

    func configure(albumTitle: String, albumImage: String, artists: String) {
        albumTitleLabel.text = albumTitle
        artistsLabel.text = artists
        let url = URL(string: albumImage)
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        albumCover.image = UIImage(data: data!)
    }
}
