//
//  JTEmployeeListProtocols.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 05/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

protocol JTEmployeeListView: class {
    var presenter: JTEmployeeListPresenter? {get set}
    
    func show(employees: [Employee])
    func showNoEmployeesFound(message: String)
    func showError(message: String)
    func enableMoreIncomingEmployees()
    func disableMoreIncomingEmployees()
    func showIndicator()
    func hideIndicator()
}

protocol JTEmployeeListPresenter: class {
    var view: JTEmployeeListView? {get set}
    var interactor: JTEmployeeListInteractor? {get set}
    
    func viewDidLoad()
    func refreshEmployeeList()
    func loadMoreEmployees()
    func recordDidSelected(index: Int)
    func deleteRecordAt(index: Int)
    func didFetch(employees: [Employee])
    func employeesFetchFailed(with error: NSError)
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
