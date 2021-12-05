//
//  TracksViewController.swift
//  MusicApp
//
//  Created by Anais Plancoulaine on 03.12.21.
//

import Foundation
import UIKit

class TracksViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    private var tracks: [Track] = []
    var selectedAlbumID: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTracks()
    }
}

extension TracksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath) as? TrackTableViewCell else { fatalError("Cell does not exist")}
        cell.configure(title: tracks[indexPath.row].title,
                       duration: "3",
                       trackNumber: tracks[indexPath.row].number,
                       artists: tracks[indexPath.row].title)
        return cell
    }

    func loadTracks() {
        let query = "http://api.deezer.com/" + "album/\(self.selectedAlbumID)/tracks"
        let request = NetworkRequest(query: query)
        request.execute(completion: { data in
            guard let data = data else { return }
            self.decode(data)
            self.tableView.reloadData()
        })
    }

    func decode(_ data: Data) {
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(Tracks.self, from: data)
            tracks = result.data ?? []
        }
        catch {
            print("Failed to decode with error: \(error)")
        }
    }
}
