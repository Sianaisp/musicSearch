//
//  UIImage + extension.swift
//  MusicApp
//
//  Created by Anais Plancoulaine on 10.12.21.
//

import UIKit

extension UIImageView {

    public func setImage(from stringUrl: String) {
        do {
            guard let url = URL(string: stringUrl) else { return }
            let data = try Data(contentsOf: url)
            self.image = UIImage(data: data)
        } catch {
            print("\(error)")
        }
    }
}
