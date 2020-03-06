//
//  JTEmployeeListProtocols.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 05/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import Foundation

protocol JTEmployeeListView: class {
    var presenter: JTEmployeeListPresenter? {get set}
    
    func show(employess: [Employee])
    func showMore(employees: [Employee])
    func showNoEmployeesFound(message: String)
    func showError(message: String)
}

protocol JTEmployeeListPresenter: class {
    var view: JTEmployeeListView? {get set}
    var interactor: JTEmployeeListInteractor? {get set}
    var router: JTEmployeeListRouter? {get set}
    
    func viewDidLoad()
    func recordDidSelected(index: Int)
    func didFetch(employees: [Employee])
    func employeesFetcFailed(with error: NSError)
}

protocol JTEmployeeListInteractor: class {
    var presenter: JTEmployeeListPresenter? {get set}
    var service: JTEmployeeService? {get set}
    
    func fetchEmployees(for pageNumber: Int)
}

protocol JTEmployeeListRouter: class {
    
    static func createModule() -> JTEmployeeListView?
    static func show(employeeDetail: Employee)
}
