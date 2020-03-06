//
//  JTEmployeeListRouter.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 06/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

class JTEmployeeListRouterImplementation: JTEmployeeListRouter {
    
    static func createModule() -> JTEmployeeListView? {
        if  let employeeListController = UIStoryboard(name: Constants.Storyboard.Main, bundle: nil).instantiateViewController(withIdentifier: "JTEmployeeListViewController") as? JTEmployeeListViewController {
            return employeeListController
        }
        return nil
    }
    
    static func show(employeeDetail: Employee) {
        
    }
    
    
}
