//
//  ViewController.swift
//  MusicApp
//
//  Created by Anais Plancoulaine on 03.12.21.
//

import UIKit

class ArtistSearchViewController: UIViewController, UISearchResultsUpdating {

    @IBOutlet private weak var tableView: UITableView!
    private let searchController = UISearchController()
    private var artists: [Artist] = []
    private var selectedArtist: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        tableView.register(UINib(nibName: Constants.artistHeaderView, bundle: nil), forHeaderFooterViewReuseIdentifier: Constants.artistHeaderView)
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard var query = searchController.searchBar.text else { return }
        if !query.isEmpty {
            query = query.replacingOccurrences(of: " ", with: "-")
            query = Constants.deezerApi + Constants.artistSearch + query
            loadArtists(query: query)
        }
    }

    func setupSearchBar() {
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        let searchBar = navigationItem.searchController?.searchBar
        searchBar?.barTintColor = .white
        searchBar?.searchTextField.leftView?.tintColor = .white
        let textFieldInsideUISearchBar = searchBar?.value(forKey: "searchField") as? UITextField
        textFieldInsideUISearchBar?.textColor = UIColor.white
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? AlbumsViewController,
           let selectedArtistID = sender as? Int {
            controller.selectedArtistID = selectedArtistID
            controller.selectedArtist = selectedArtist
        }
    }
}

extension ArtistSearchViewController: UITableViewDataSource, UITableViewDelegate {


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.headerHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.artistHeaderView) as! ArtistsHeaderView
    return headerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = Constants.artistCellIdentifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                       for: indexPath) as? ArtistTableViewCell else { fatalError("Could not dequeue cell")}
        cell.configure(artist: artists[indexPath.row].name,
                       image: artists[indexPath.row].picture ?? "")
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArtist = artists[indexPath.row].name
        presentAlbumsCollections(selectedArtistID: artists[indexPath.row].id)
    }

    func presentAlbumsCollections(selectedArtistID: Int) {
        performSegue(withIdentifier: Constants.albumSegueIdentifier,
                     sender: selectedArtistID)
    }
}

extension ArtistSearchViewController {
    func loadArtists(query: String) {
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
            let result = try decoder.decode(Artists.self, from: data)
            artists = result.data ?? []
        }
        catch {
            print("Failed to decode with error: \(error)")
        }
    }
}
