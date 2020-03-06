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
        
    }
    
}
