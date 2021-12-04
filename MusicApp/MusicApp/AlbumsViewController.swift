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
    var selectedArtistID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? TracksViewController,
           let selectedAlbumID = sender as? Int {
            controller.selectedAlbumID = selectedAlbumID
        }
    }
}

extension AlbumsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as? AlbumCollectionViewCell else { fatalError("Cell does not exist")}
        cell.configure(albumTitle: "hello", albumImage: UIImage(), artists: "Adele")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentTracks(selectedAlbumID: 299937)
    }

    func presentTracks(selectedAlbumID: Int?) {
        performSegue(withIdentifier: "tracks.segue.identifier",
                     sender: selectedAlbumID)
    }
}
