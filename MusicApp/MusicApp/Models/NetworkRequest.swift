//
//  NetworkRequest.swift
//  MusicApp
//
//  Created by Anais Plancoulaine on 05.12.21.
//

import Foundation

class NetworkRequest {

    let query: String

    init(query: String) {
        self.query = query
    }

    func execute(completion: @escaping (Data?) -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: query)! as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data: Data?, _, error) -> Void in
            guard error == nil else { return }
            DispatchQueue.main.async {
                completion(data)
            }
        })
        task.resume()
    }
}
