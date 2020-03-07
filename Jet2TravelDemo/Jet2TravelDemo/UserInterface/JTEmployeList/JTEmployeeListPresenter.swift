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
        JTEmployeeListRouterImplementation.show(employeeDetail: self.employees[index])
    }
    
    func deleteRecordAt(index: Int) {
        self.employees.remove(at: index)
        guard let view = self.view else {return}
        view.show(employees: self.employees)
    }
    
    func didFetch(employees: [Employee]) {
        self.employees.append(contentsOf: employees)
        guard let view = self.view else {return}
        view.hideIndicator()
        (self.employees.count < self.totalRecords) ? (view.enableMoreIncomingEmployees()) : (view.disableMoreIncomingEmployees())
        if employees.count == 0 {
            if self.pageNumber == 0 {
                view.showNoEmployeesFound(message: Messages.NoEmployeesFound)
            }else {
                self.pageNumber -= 1
            }
        }else {
            view.show(employees: self.employees)
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
    
    func sortByName() {
        self.employees.sort { (employee1, employee2) -> Bool in
            guard let name1 = employee1.name, let name2 = employee2.name else {return false}
            return name1.compare(name2) == .orderedAscending
        }
        if let view = self.view {
            view.show(employees: self.employees)
        }
    }
    
    func sortByAge() {
        self.employees.sort { (employee1, employee2) -> Bool in
            guard let age1 = employee1.age, let age2 = employee2.age else {return false}
            return age1 < age2
        }
        if let view = self.view {
            view.show(employees: self.employees)
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
