//
//  UIViewController+Extension.swift
//  Workout
//
//  Created by IVAN CHERNOV on 24.10.21.
//

import UIKit

extension UIViewController {
    func showSimpleAlert(title: String, text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
