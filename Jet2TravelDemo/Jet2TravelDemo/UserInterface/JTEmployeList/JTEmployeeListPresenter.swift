//
//  JTEmployeeListPresenter.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 06/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import Foundation

class JTEmployeeListPresenterImplementation: JTEmployeeListPresenter {
    
    private enum Messages {
        static let NoEmployeesFound = "No employees found"
    }
    
    weak var view: JTEmployeeListView?
    var interactor: JTEmployeeListInteractor?
    var router: JTEmployeeListRouter?
    private var pageNumber: Int = 0
    private var totalRecords: Int = 50
    private var employees = [Employee]()
    
    func viewDidLoad() {
        self.loadInitialEmployees()
    }
    
    func refreshEmployeeList(){
        self.loadInitialEmployees()
    }
    
    func loadMoreEmployees(){
        self.pageNumber += 1
        self.fetchEmployees()
    }
    
    func recordDidSelected(index: Int) {
        
    }
    
    func didFetch(employees: [Employee]) {
        self.employees.append(contentsOf: employees)
        guard let view = self.view else {return}
        view.hideIndicator()
        (self.employees.count < self.totalRecords) ? (view.enableMoreIncomingEmployees()) : (view.disableMoreIncomingEmployees())
        if employees.count == 0 {
            if self.pageNumber == 0 {
                DispatchQueue.main.async {
                    view.showNoEmployeesFound(message: Messages.NoEmployeesFound)
                }
            }else {
                self.pageNumber -= 1
            }
        }else {
            DispatchQueue.main.async {
                view.show(employees: self.employees)
            }
        }
    }
    
    func employeesFetchFailed(with error: NSError) {
        if self.pageNumber > 0 {
            self.pageNumber -= 1
        }
        if let view = self.view {
            view.hideIndicator()
            DispatchQueue.main.async {
                view.showError(message: error.localizedDescription)
            }
        }
    }
    
    private func loadInitialEmployees(){
        self.setup()
        self.fetchEmployees()
    }
    
    private func setup(){
        self.pageNumber = 0
        self.employees.removeAll()
    }
    
    private func fetchEmployees(){
        if let view = self.view {
            view.showIndicator()
        }
        if let interactor = self.interactor {
            interactor.fetchEmployees(for: self.pageNumber)
        }
    }
    
}
