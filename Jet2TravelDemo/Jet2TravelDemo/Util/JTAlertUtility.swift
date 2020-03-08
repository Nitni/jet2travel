//
//  JTAlertUtility.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 06/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

/// Function block to be called on click of positive option selected by user when alert is displayed.
typealias OKClickHandler = () -> Void

/// Structure modelling the action to be displayed with alert and action sheet.
struct JTActionModel {
    var title: String?
    var action: () -> Void?
}

/// Alert type
enum AlertType {
    case single
    case double
}

/// Alert utility class used to display alert and action sheet across the applcation
class JTAlertUtility {
    
    // MARK: - Constants
    private enum AlertConstants {
        static let LocalizedOKKey = "OK"
        static let LocalizedDeleteKey = "Delete"
        static let LocalizedCancelKey = "Cancel"
    }
    
    // MARK: - Public methods
    
    /**
     Show alert on screen with delay.
     
     - Parameters:
        - message: Alert message to be displayed
        - delay: delay in secods before displaying alert.
        - type: Type of alert to be displayed
        - okClickHandler: Function block to be called on click of positive option selected by user.
        - controller: Source controller instance in which to show alert.
     */
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
    
    /**
    Show single action alert on screen
    
    - Parameters:
       - message: Alert message to be displayed
       - controller: Source controller instance in which to show alert.
    */
    static func showSingleActionAlert(with message: String, in controller: UIViewController) {
        let alertController = UIAlertController(title: Constants.ApplicationName, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: NSLocalizedString(AlertConstants.LocalizedOKKey, comment: ""), style: .default, handler: nil)
        alertController.addAction(action)
        controller.present(alertController, animated: true, completion: nil)
    }
    
    /**
    Show double action alert on screen
    
    - Parameters:
       - message: Alert message to be displayed
       - okClickHandler: Function block to be called on click of positive option selected by user.
       - controller: Source controller instance in which to show alert.
    */
    
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
    
    /**
    Show action sheet on screen
    
    - Parameters:
       - title: Action sheet title
       - actions: List  containing data model representing a single action for action sheet with title and click handler.
       - controller: Source controller instance in which to show action sheet.
    */
    
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
