
//
//  JTEmployeeDetailsRouter.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 07/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

class JTEmployeeDetailsRouterImpementation: JTEmployeeDetailsRouter {
    
    static func moveBack() {
        if let navigationController = AppDelegate.shared().navigationController?.topViewController?.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    
}
