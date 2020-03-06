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
        static let SuccessResponseKey = "success"
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
                    let responseStatus = response[Constants.API.StatusKey] as? String,
                    responseStatus == ServiceConstants.SuccessResponseKey else {
                        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: Constants.ErrorMessages.FailedResponse])
                        completionBlock(nil, error)
                    return
                }
                guard let responseData = response[Constants.API.ResponseDataKey] as? [[String: Any]] else {
                        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: Constants.ErrorMessages.InvalidResponseDataFormat])
                        completionBlock(nil, error)
                    return
                }
                var employees = [Employee]()
                for employeeObject in responseData {
                    guard let employeeJSONData = try? JSONSerialization.data(withJSONObject: employeeObject, options: []),
                        var employee = try? JSONDecoder().decode(EmployeeImplementation.self, from: employeeJSONData) else {
                            return
                    }
                    employee.image = "https://tinyurl.com/vkdd8yw"
                    employees.append(employee)
                }
                completionBlock(employees, nil)
            }
        }
    }
}
