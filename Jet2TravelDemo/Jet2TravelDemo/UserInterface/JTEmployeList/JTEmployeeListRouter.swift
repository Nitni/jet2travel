//
//  JTEmployeeListRouter.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 06/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

class JTEmployeeListRouterImplementation: JTEmployeeListRouter {
    
    private enum RouterConstants {
        static let EmployeeListControllerIdentifier = "JTEmployeeListViewController"
    }
    
    static func createModule() -> JTEmployeeListView? {
        if  let employeeListController = UIStoryboard(name: Constants.Storyboard.Main, bundle: nil).instantiateViewController(withIdentifier: RouterConstants.EmployeeListControllerIdentifier) as? JTEmployeeListViewController {
            let presenter = JTEmployeeListPresenterImplementation()
            let interactor = JTEmployeeListInteractorImplementation()
            let service = JTEmployeeServiceImplementation(requestManager: RequestManagerImplementation(urlSession: URLSession.shared, responseParser: JTResponseParserImplementation()))
            interactor.service = service
            presenter.interactor = interactor
            interactor.presenter = presenter
            presenter.view = employeeListController
            employeeListController.presenter = presenter
            return employeeListController
        }
        return nil
    }
    
    static func show(employeeDetail: Employee) {
        
    }
    
    
}
