//
//  ArtistModel.swift
//  MusicApp
//
//  Created by Anais Plancoulaine on 05.12.21.
//

import Foundation

enum Types {
    case Artists
    case Albums
    case Tracks
}

struct Artists: Codable {
    let data: [Artist]?
    let total: Int
}

struct Artist: Codable {
    let name: String
    let picture: String?
    let id: Int

    enum CodingKeys: String, CodingKey {
        case name
        case picture = "picture_big"
        case id
    }
}
