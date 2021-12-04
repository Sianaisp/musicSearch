//
//  TracksViewController.swift
//  MusicApp
//
//  Created by Anais Plancoulaine on 03.12.21.
//

import Foundation
import UIKit

class TracksViewController: UIViewController {

    var selectedAlbumID: Int = 0
    private var tracks = [Track]()
    @IBOutlet private weak var tableView: UITableView!

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
        cell.configure(title: tracks[indexPath.row].trackTitle,
                       duration: "3",
                       trackNumber: tracks[indexPath.row].trackNumber,
                       artists: tracks[indexPath.row].trackTitle)
        return cell
    }

    func loadTracks() {
        let query = "http://api.deezer.com/" + "album/\(self.selectedAlbumID)/tracks"
        getRequest(query: query, completion: { tracks, _ in
            DispatchQueue.main.async {
                self.tracks = tracks as? [Track] ?? []
                self.tableView.reloadData()
            }
        })
    }

    func getRequest(query: String, completion: @escaping ([Any], Int) -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: query)! as URL)
        let session = URLSession.shared
        request.httpMethod = "GET"
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            var requestArray = [Any]()
            guard error == nil else { return }
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any],
                let array = json["data"] as? NSArray {
                    for case let result in array {
//                        if let object = Artist.parse(result as! [String : Any]) {
//                            requestArray.append(object)
//                        }
//                        if let object = Album.parse(result as! [String : Any]){
//                            requestArray.append(object)
//                        }
                        if let object = Track.parse(result as! [String : Any]){
                            requestArray.append(object)
                        }
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
            completion(requestArray, 0 )
        })
        task.resume()
    }
}
