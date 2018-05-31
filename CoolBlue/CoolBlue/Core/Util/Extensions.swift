//
//  Extensions.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 31/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import Foundation
import UIKit

extension Int {
    var currency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "nl_NL")
        return formatter.string(from: NSNumber(value: self))!
    }
}

extension UIColor {
    struct AppColor {
        static let blue = UIColor(red: 61/255, green: 143/255, blue: 221/255, alpha: 1)
    }
}
