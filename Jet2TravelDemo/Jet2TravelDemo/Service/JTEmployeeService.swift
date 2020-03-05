//
//  JTEmployeeService.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 05/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//
import Foundation

typealias EmployeeListCompletion = ([Employee]?, NSError?) -> Void

protocol JTEmployeeService {
    var requestManager: RequestManager {get set}
    func getEmployees(with completionBlock: @escaping EmployeeListCompletion)
}

class JTEmployeeServiceImplementation: JTEmployeeService {
    
    private enum ServiceConstants {
        static let EmployeeNameKey = "employee_name"
        static let EmployeeImageKey = "profile_image"
        static let EmployeeSalaryKey = "employee_salary"
        static let EmployeeAgeKey = "employee_age"
    }
    
    var requestManager: RequestManager
    
    init(requestManager: RequestManager) {
        self.requestManager = requestManager
    }
    
    func getEmployees(with completionBlock: @escaping EmployeeListCompletion) {
        let employeeListEndpoint = Constants.API.BaseEndpoint + Constants.API.EmployeeListEndpoint
        self.requestManager.get(url: employeeListEndpoint) { (response, error) in
            if let error = error{
                completionBlock(nil, error)
            } else {
                guard let response = response,
                    let responseData = response[Constants.API.ResponseDataKey] as? [[String: Any]] else {
                        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: Constants.ErrorMessages.InvalidResponseDataFormat])
                        completionBlock(nil, error)
                    return
                }
                var employees = [Employee]()
                for employeeObject in responseData {
                    guard let employeeName = employeeObject[ServiceConstants.EmployeeNameKey] as? String,
                        let employeeImage = employeeObject[ServiceConstants.EmployeeImageKey] as? String,
                        let employeeAge = employeeObject[ServiceConstants.EmployeeAgeKey] as? String,
                        let employeeSalary = employeeObject[ServiceConstants.EmployeeSalaryKey] as? String else {
                        return
                    }
                    
                    let employee = EmployeeImplementation(name: employeeName,
                                                          image: employeeImage,
                                                          salary: NSDecimalNumber(string: employeeSalary) as Decimal,
                                                          age: Int(employeeAge))
                    employees.append(employee)
                }
                completionBlock(employees, nil)
            }
        }
    }
}
