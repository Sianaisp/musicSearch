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
        let noOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell",
                                                            for: indexPath) as? AlbumCollectionViewCell else { fatalError("Cell does not exist")}
        cell.configure(albumTitle: albums[indexPath.row].title,
                       albumImage: albums[indexPath.row].cover ?? "",
                       artists: "names of artists")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentTracks(selectedAlbumID: albums[indexPath.row].id)
    }

    func presentTracks(selectedAlbumID: Int?) {
        performSegue(withIdentifier: "tracks.segue.identifier",
                     sender: selectedAlbumID)
    }
}

extension AlbumsViewController {
    func loadAlbums() {
        let query = "http://api.deezer.com/" + "artist/\(self.selectedArtistID)/albums"
        let request = NetworkRequest(query: query)
        request.execute(completion: { data in
            guard let data = data else { return }
            self.decode(data)
            self.collectionView.reloadData()
        })
    }

    func decode(_ data: Data) {
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(Albums.self, from: data)
            albums = result.data ?? []
        }
        catch {
            print("Failed to decode with error: \(error)")
        }
    }
}
