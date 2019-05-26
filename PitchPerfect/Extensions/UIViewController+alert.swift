//
//  UIViewController+alert.swift
//  PitchPerfect
//
//  Created by Jha, Vasudha on 26/05/19.
//  Copyright © 2019 Jha, Vasudha. All rights reserved.
//

import UIKit

extension UIViewController {
    
     func showAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Alerts.DismissAlert, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
