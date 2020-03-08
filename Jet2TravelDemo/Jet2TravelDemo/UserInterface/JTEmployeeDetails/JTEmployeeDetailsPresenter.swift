//
//  JTEmployeeDetailsPresenter.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 07/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import Foundation

class JTEmployeeDetailsPresenterImplementation: JTEmployeeDetailsPresenter {
    
    // MARK: - Variables
    weak var view: JTEmployeeDetailsView?
    var employee: Employee?
    
    // MARK: - Public methods
    
    func viewDidLoad() {
        guard  let view = self.view,
            let employee = self.employee else {return}
        
        guard let profileImageUrl = employee.image else {
            view.showPlaceholderProfileImage()
            return
        }
        
        view.show(profileImage: profileImageUrl)
        
        var nameAge = ""
        if let age = employee.age, age != 0,
            let name = employee.name, !name.isEmpty {
            nameAge = name + ", " + String(age)
        } else if let name = employee.name, !name.isEmpty {
            nameAge = name
        } else if let age = employee.age, age != 0 {
            nameAge = String(age)
        }
        view.show(nameAge: nameAge)
        
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        
        if let salary = employee.salary,
            let formattedSalary = formatter.string(from: NSDecimalNumber(decimal: salary)) {
            view.show(salary: formattedSalary)
        }
    }
    
    func back() {
        JTEmployeeDetailsRouterImpementation.moveBack()
    }
}
