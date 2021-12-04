//
//  AlbumsCollectionViewController.swift
//  MusicApp
//
//  Created by Anais Plancoulaine on 03.12.21.
//

import Foundation
import UIKit

class AlbumsViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    private var albums = [Album]()
    var selectedArtistID: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        loadAlbums()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? TracksViewController,
           let selectedAlbumID = sender as? Int {
            controller.selectedAlbumID = selectedAlbumID
        }
    }
}

extension AlbumsViewController: UICollectionViewDelegate,
                                    UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/2
        let yourHeight = yourWidth

        return CGSize(width: yourWidth, height: yourHeight)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as? AlbumCollectionViewCell else { fatalError("Cell does not exist")}
        cell.configure(albumTitle: albums[indexPath.row].albumTitle,
                       albumImage: albums[indexPath.row].albumCover ?? "",
                       artists: albums[indexPath.row].albumTitle)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentTracks(selectedAlbumID: albums[indexPath.row].albumId)
    }

    func presentTracks(selectedAlbumID: Int?) {
        performSegue(withIdentifier: "tracks.segue.identifier",
                     sender: selectedAlbumID)
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
                        if let object = Album.parse(result as! [String : Any]){
                            requestArray.append(object)
                        }
//                        if let object = Track.parse(result as! [String : Any]){
//                            requestArray.append(object)
//                        }
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
            completion(requestArray, 0 )
        })
        task.resume()
    }

    func loadAlbums() {
        let query = "http://api.deezer.com/" + "artist/\(self.selectedArtistID)/albums"
        getRequest(query: query) { albums, total in
            DispatchQueue.main.async {
                self.albums = albums as? [Album] ?? []
                self.collectionView.reloadData()
            }
//            if total > 25 {
//                for i in 25..<total where i%25 == 0 {
//                    let query = "http://api.deezer.com/artist/\(self.selectedArtistID)/albums?index=\(i)"
//                    self.getRequest(query: query) { albums, total in
//                        DispatchQueue.main.async {
//                            self.albums += albums as! [Album]
//                            self.collectionView?.reloadData()
//                            self.collectionView?.scrollRectToVisible(CGRect.zero, animated: false)
//                        }
//                    }
//                }
//            }
        }
    }
}
