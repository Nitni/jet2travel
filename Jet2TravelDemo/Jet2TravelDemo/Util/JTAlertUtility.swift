//
//  JTAlertUtility.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 06/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

typealias OKClickHandler = () -> Void

struct JTActionModel {
    var title: String?
    var action: () -> Void?
}

enum AlertType {
    case single
    case double
}

class JTAlertUtility {
    
    private enum AlertConstants {
        static let LocalizedOKKey = "OK"
        static let LocalizedDeleteKey = "Delete"
        static let LocalizedCancelKey = "Cancel"
    }
    
    static func showAlert(with message: String,
                          delay: DispatchTime,
                          type: AlertType,
                          okClickHandler: OKClickHandler?,
                          in controller: UIViewController){
        switch type {
        case .single:
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.showSingleActionAlert(with: message, in: controller)
            }
        case .double:
            if let okClickHandler = okClickHandler {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.showDoubleActionAlert(with: message, okClickHandler: okClickHandler, in: controller)
                }
            }
        }
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
    
    static func showActiomsheet(with title: String, actions: [JTActionModel], in controller: UIViewController) {
        let actionsheetController = UIAlertController(title: title, message: "", preferredStyle: .actionSheet)
        
        for action in actions {
            let alertAction = UIAlertAction(title: action.title, style: .default) { (alertAction) in
                action.action()
            }
            actionsheetController.addAction(alertAction)
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString(AlertConstants.LocalizedCancelKey, comment: ""), style: .destructive, handler: nil)
        actionsheetController.addAction(cancelAction)
        controller.present(actionsheetController, animated: true, completion: nil)
    }
}
