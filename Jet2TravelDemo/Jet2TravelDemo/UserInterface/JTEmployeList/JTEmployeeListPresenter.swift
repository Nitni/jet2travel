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
        guard let view = self.view else {return}
        if employees.count == 0 {
            if self.pageNumber > 0 {
                self.pageNumber -= 1
            }
            DispatchQueue.main.async {
                view.showNoEmployeesFound(message: Messages.NoEmployeesFound)
            }
            
        }else {
            self.pageNumber == 0 ? DispatchQueue.main.async {
                view.show(employess: employees)
            }  : DispatchQueue.main.async {
                view.showMore(employees: employees)
            }
        }
    }
    
    func employeesFetchFailed(with error: NSError) {
        if self.pageNumber > 0 {
            self.pageNumber -= 1
        }
        if let view = self.view {
            DispatchQueue.main.async {
                view.showError(message: error.localizedDescription)
            }
           
        }
    }
    
    private func loadInitialEmployees(){
        self.pageNumber = 0
        self.fetchEmployees()
    }
    
    private func fetchEmployees(){
        if let interactor = self.interactor {
            interactor.fetchEmployees(for: self.pageNumber)
        }
    }
    
}
