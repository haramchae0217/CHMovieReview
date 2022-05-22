//
//  UIAlertController++Extension.swift
//  CHMovieReview
//
//  Created by Chae_Haram on 2022/05/22.
//

import Foundation
import UIKit

extension UIAlertController {
    static func showAlert(message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: "⚠️", message: message, preferredStyle: .alert)
        let doneButton = UIAlertAction(title: "확인", style: .default)
        alert.addAction(doneButton)
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
