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
        // Do any additional setup after loading the view.
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
        16
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "artistCell", for: indexPath) as? ArtistTableViewCell else { fatalError("Celll does not exist")}
        cell.configure(artist: "Blabla", image: UIImage())
        return cell
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        presentAlbumsCollections(selectedArtistID: 938383)
    }

    func presentAlbumsCollections(selectedArtistID: Int) {
        performSegue(withIdentifier: "albums.segue.identifier",
                    sender: selectedArtistID)
    }


}

