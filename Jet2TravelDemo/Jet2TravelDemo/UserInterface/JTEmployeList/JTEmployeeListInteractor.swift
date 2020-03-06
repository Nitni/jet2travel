//
//  JTEmployeeListInteractor.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 06/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

class JTEmployeeListInteractorImplementation: JTEmployeeListInteractor {
    weak var presenter: JTEmployeeListPresenter?
    
    var service: JTEmployeeService?
    
    func fetchEmployees(for pageNumber: Int) {
        guard let presenter = self.presenter, let service = self.service else {
            return
        }
        service.getEmployees { (employees, error) in
            if let error = error {
                presenter.employeesFetchFailed(with: error)
            }else if let employees = employees {
                presenter.didFetch(employees: employees)
            }
        }
    }
    
}
