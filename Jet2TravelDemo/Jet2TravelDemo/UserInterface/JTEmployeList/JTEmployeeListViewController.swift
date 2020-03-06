//
//  JTEmployeeListViewController.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 05/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

class JTEmployeeListViewController: UIViewController {
    
    var presenter: JTEmployeeListPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let presenter = self.presenter {
            presenter.viewDidLoad()
        }
    }
}

extension JTEmployeeListViewController: JTEmployeeListView{
    
    
    func show(employess: [Employee]) {
        
    }
    
    func showMore(employees: [Employee]) {
        
    }
    
    func showNoEmployeesFound(message: String) {
        
    }
    
    func showError(message: String) {
        JTAlertUtility.showAlert(with: message, in: self)
    }
    
    
}
