//
//  JTAlertUtility.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 06/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

typealias OKClickHandler = () -> Void

class JTAlertUtility {
    
    private enum AlertConstants {
        static let LocalizedOKKey = "OK"
        static let LocalizedDeleteKey = "Delete"
        static let LocalizedCancelKey = "Cancel"
    }
    
    static func showSingleActionAlert(with message: String, in controller: UIViewController) {
        let alertController = UIAlertController(title: Constants.ApplicationName, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: NSLocalizedString(AlertConstants.LocalizedOKKey, comment: ""), style: .default, handler: nil)
        alertController.addAction(action)
        controller.present(alertController, animated: true, completion: nil)
    }
    
    static func showDoubleActionAlert(with message: String,
                                      okClickHandler: @escaping OKClickHandler,
                                      in controller: UIViewController) {
        let alertController = UIAlertController(title: Constants.ApplicationName, message: message, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: NSLocalizedString(AlertConstants.LocalizedDeleteKey, comment: ""), style: .default) { (action) in
            okClickHandler()
        }
        alertController.addAction(deleteAction)
        let cancelAction = UIAlertAction(title: NSLocalizedString(AlertConstants.LocalizedCancelKey, comment: ""), style: .destructive, handler: nil)
        alertController.addAction(cancelAction)
        controller.present(alertController, animated: true, completion: nil)
    }
}
