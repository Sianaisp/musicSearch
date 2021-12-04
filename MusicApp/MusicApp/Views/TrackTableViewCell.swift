//
//  TrackTableViewCell.swift
//  MusicApp
//
//  Created by Anais Plancoulaine on 04.12.21.
//

import Foundation
import UIKit

final class TrackTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var artistNamesLabel: UILabel!

    func configure(title: String, duration: String, trackNumber: Int, artists: String) {
        titleLabel.text = title
        durationLabel.text = duration
        numberLabel.text = String(trackNumber)
        artistNamesLabel.text = artists
    }
}
