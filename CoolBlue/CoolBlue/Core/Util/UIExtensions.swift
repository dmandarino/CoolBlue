//
//  Extensions.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 31/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Int

extension Int {
    var currency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "nl_NL")
        return formatter.string(from: NSNumber(value: self))!
    }
}

//MARK: - UIColor

extension UIColor {
    struct AppColor {
        static let blue = UIColor(red: 61/255, green: 143/255, blue: 221/255, alpha: 1)
    }
}

//MARK: - UIAlertController

extension UIAlertController {
    
    static func getAlertError(callback: @escaping () -> ()) -> UIAlertController {
        let alertController = UIAlertController(title: "Oops", message: "Something went wrong. Do you want to try again?", preferredStyle: .alert)
        let tryAgainAction = UIAlertAction(title: "Try Again", style: .default) { (action:UIAlertAction) in
            callback()
        }
        let dissmissAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(tryAgainAction)
        alertController.addAction(dissmissAction)
        
        return alertController
    }
}

//MARK: - String

extension String {
    var withoutHtmlTags: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}

//MARK: - UIImage

extension UIImage {
    var placeholder: UIImage {
        return UIImage(named: "placeholder")!
    }
}

