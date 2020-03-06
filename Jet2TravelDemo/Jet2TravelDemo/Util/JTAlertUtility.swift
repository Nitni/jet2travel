//
//  JTAlertUtility.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 06/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

class JTAlertUtility {
    
    private enum AlertConstants {
        static let LocalizedOKKey = "OK"
    }
    
    static func showAlert(with message: String, in controller: UIViewController) {
        let alertController = UIAlertController(title: Constants.ApplicationName, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: NSLocalizedString(AlertConstants.LocalizedOKKey, comment: ""), style: .default, handler: nil)
        alertController.addAction(action)
        controller.present(alertController, animated: true, completion: nil)
    }
}
