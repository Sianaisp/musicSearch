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
    private var albums: [Album] = []
    var selectedArtistID: Int = 0
    var selectedArtist: String?
    var selectedAlbumUrl: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadAlbums()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? TracksViewController,
           let selectedAlbumID = sender as? Int {
            controller.selectedAlbumID = selectedAlbumID
            controller.selectedAlbumCoverUrl = selectedAlbumUrl
            controller.selectedArtist = selectedArtist
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
        return CGSize(width: size, height: size + 50)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.albumCellIdentifier,
                                                            for: indexPath) as? AlbumCollectionViewCell else { fatalError("Cell does not exist")}
        cell.configure(albumTitle: albums[indexPath.row].title,
                       albumImage: albums[indexPath.row].cover ?? "",
                       artists: selectedArtist ?? "")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedAlbumUrl = albums[indexPath.row].cover
        presentTracks(selectedAlbumID: albums[indexPath.row].id)
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                            withReuseIdentifier: Constants.albumHeaderView,
                                                                            for: indexPath as IndexPath) as? AlbumHeaderView {
            headerView.configure(artist: selectedArtist ?? "",
                                 hasSeveralAlbums: albums.count > 1)
            return headerView
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width,
                      height: 60)
    }

    func presentTracks(selectedAlbumID: Int?) {
        performSegue(withIdentifier: Constants.tracksSegueIdentifier,
                     sender: selectedAlbumID)
    }
}

extension AlbumsViewController {
    func loadAlbums() {
        let query = Constants.deezerApi + "artist/\(self.selectedArtistID)/albums"
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

    func setupCollectionView() {
        collectionView.register(UINib(nibName: Constants.albumHeaderView, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: Constants.albumHeaderView)
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionHeadersPinToVisibleBounds = true
    }
}
