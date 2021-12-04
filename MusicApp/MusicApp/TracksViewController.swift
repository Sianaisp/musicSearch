//
//  TracksViewController.swift
//  MusicApp
//
//  Created by Anais Plancoulaine on 03.12.21.
//

import Foundation
import UIKit

class TracksViewController: UIViewController {

    var selectedAlbumID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension TracksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath) as? TrackTableViewCell else { fatalError("Cell does not exist")}
        cell.configure(title: "is it me", duration: "7:36", trackNumber: 3, artists: "blabla")
        return cell
    }

}
