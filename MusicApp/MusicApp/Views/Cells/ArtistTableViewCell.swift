//
//  ArtistTableViewCell.swift
//  MusicApp
//
//  Created by Anais Plancoulaine on 04.12.21.
//

import Foundation
import UIKit

final class ArtistTableViewCell: UITableViewCell {

    @IBOutlet private weak var artistName: UILabel!
    @IBOutlet private weak var artistImage: UIImageView!

    func configure(artist: String, imageUrl: String) {
        artistName.text = artist
        artistImage.setImage(from: imageUrl)
    }
}
