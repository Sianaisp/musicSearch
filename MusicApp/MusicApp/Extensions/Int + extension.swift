//
//  Int + extension.swift
//  MusicApp
//
//  Created by Anais Plancoulaine on 10.12.21.
//

import Foundation

extension Int {
      func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
        formatter.unitsStyle = style
        return formatter.string(from: TimeInterval(self)) ?? ""
      }
}
