//
//  JTEmployeeListPresenter.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 06/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import Foundation

class JTEmployeeListPresenterImplementation: JTEmployeeListPresenter {
    
    weak var view: JTEmployeeListView?
    var interactor: JTEmployeeListInteractor?
    var router: JTEmployeeListRouter?
    
    func viewDidLoad() {
        
    }
    
    func recordDidSelected(index: Int) {
        
    }
    
    func didFetch(employees: [Employee]) {
        
    }
    
    func employeesFetcFailed(with error: NSError) {
        
    }
    
}
