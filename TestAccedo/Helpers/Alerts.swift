//
//  Alerts.swift
//  TestAccedo
//
//  Created by MacBook Pro on 01/11/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, style: UIAlertController.Style) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
