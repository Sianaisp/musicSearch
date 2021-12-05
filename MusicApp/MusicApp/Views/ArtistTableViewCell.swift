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
        let url = URL(string: image)
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        artistImage.image = UIImage(data: data!)
    }
}
