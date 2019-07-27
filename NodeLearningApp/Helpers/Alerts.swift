//
//  Alerts.swift
//  NodeLearningApp
//
//  Created by Faraz on 27/07/19.
//  Copyright © 2019 Faraz. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
    weak var controller: UIViewController?
    
    convenience init(vc: UIViewController?) {
        self.init()
        controller = vc
    }
    
    func showAlert(title: String, message: String, viewController: UIViewController, completion: ((Any?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: completion))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(message: String, viewController: UIViewController) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title: String) {
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        controller?.present(alert, animated: true, completion: nil)
    }
    
    func showPermissionAlert(title: String, message: String, cancelSelector: ((Any?) -> Void)?, completion: ((Any?) -> Void)?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: cancelSelector))
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: completion))
        controller?.present(alert, animated: true, completion: nil)
    }
    
    func showDeleteFieldAlert(alertTitle: String, alertMessage: String?, completion: ((Any?) -> Void)?) {
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: completion))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        controller?.present(alert, animated: true, completion: nil)
    }
    
    func showNoInternetRetryAlert(alertTitle: String, alertMessage: String?,onController: UIViewController, completion: @escaping ((Bool) -> ())) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (action) in
            completion(true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { ( action) in
            completion(false)
        }))
        onController.present(alert, animated: true, completion: nil)
    }
}
