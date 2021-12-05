//
//  AlbumModel.swift
//  MusicApp
//
//  Created by Anais Plancoulaine on 04.12.21.
//

import Foundation
import UIKit

struct Albums: Codable {
    let data: [Album]?
    let total: Int
}

struct Album: Codable {
    let title: String
    let cover: String?
    let id: Int

    enum CodingKeys: String, CodingKey {
        case title
        case cover = "cover_big"
        case id
    }
}
