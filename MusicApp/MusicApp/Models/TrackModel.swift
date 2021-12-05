//
//  TrackModel.swift
//  MusicApp
//
//  Created by Anais Plancoulaine on 05.12.21.
//

import Foundation

struct Tracks: Codable {
    let data: [Track]?
    let total: Int
}

struct Track: Codable {
    let title: String
    let number: Int
    let duration: Int
    let id: Int

    enum CodingKeys: String, CodingKey {
        case title
        case number = "track_position"
        case duration
        case id
    }
}
