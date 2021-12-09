//
//  ArtistTableViewCell.swift
//  MusicApp
//
//  Created by Anais Plancoulaine on 04.12.21.
//

import Foundation
import UIKit

final class ArtistTableViewCell: UITableViewCell {

    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var artistImage: UIImageView!

    func configure(artist: String, image: String) {
        artistName.text = artist
        do {
            guard let url = URL(string: image) else { return }
            let data = try Data(contentsOf: url)
            artistImage.image = UIImage(data: data)
        } catch {
         print("\(error)")
        }
    }
}
