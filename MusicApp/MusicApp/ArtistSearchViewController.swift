//
//  ViewController.swift
//  MusicApp
//
//  Created by Anais Plancoulaine on 03.12.21.
//

import UIKit

class ArtistSearchViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    private var artists = [Artist]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadArtists()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? AlbumsViewController,
           let selectedArtistID = sender as? Int {
            controller.selectedArtistID = selectedArtistID
        }
    }
}

extension ArtistSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "artistCell", for: indexPath) as? ArtistTableViewCell else { fatalError("Celll does not exist")}
        cell.configure(artist: artists[indexPath.row].artistName,
                       image: artists[indexPath.row].artistImage ?? "")
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentAlbumsCollections(selectedArtistID: artists[indexPath.row].artistId)
    }

    func presentAlbumsCollections(selectedArtistID: Int) {
        performSegue(withIdentifier: "albums.segue.identifier",
                    sender: selectedArtistID)
    }

    func getRequest(query: String, completion: @escaping ([Any], Int) -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: query)! as URL)
        let session = URLSession.shared
        request.httpMethod = "GET"
        session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            var requestArray = [Any]()
            var total = 0
            guard error == nil else { return }
            guard let data = data else { return }
            do {

                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any],
                let array = json["data"] as? NSArray {
                    total = (json["total"] as? Int)!
                    for case let result in array {
                        if let object = Artist.parse(result as! [String : Any]) {
                            requestArray.append(object)
                        }
//                        if let object = Album.parse(result as! [String : Any]){
//                            requestArray.append(object)
//                        }
//                        if let object = Track.parse(result as! [String : Any]){
//                            requestArray.append(object)
//                        }
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
        completion(requestArray, total)
        }).resume()
        ////////
//        session.dataTask(with: request as URLRequest, completionHandler: { data,_,_ in
//            var requestArray = [Any]()
//            var total = 0
//            if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let array = json["data"] as? NSArray {
//                total = (json["total"] as? Int)!
//                for case let result in array {
//                    if let object = Artist.parse(result as! [String : Any]) {
//                        requestArray.append(object)
//                    }
//                }
//            }
//            completion(requestArray, total)
//        }).resume()
    }

    func loadArtists() {
        let query = "http://api.deezer.com/" + "search/artist?q=radiohead"
        getRequest(query: query) { artists, _ in
            DispatchQueue.main.async {
                self.artists = artists as? [Artist] ?? []
                self.tableView.reloadData()
            }
        }
    }
}

