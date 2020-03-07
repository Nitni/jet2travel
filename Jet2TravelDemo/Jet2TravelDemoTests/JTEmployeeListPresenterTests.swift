//
//  JTEmployeeListPresenterTests.swift
//  Jet2TravelDemoTests
//
//  Created by Nitin Manghwani on 07/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import XCTest
@testable import Jet2TravelDemo

class JTEmployeeListInteractorMock: JTEmployeeListInteractor {
    weak var presenter: JTEmployeeListPresenter?
    
    var service: JTEmployeeService?
    
    func fetchEmployees(for pageNumber: Int) {
        if let presenter = self.presenter {
            let employeeJson = "{\"status\":\"success\",\"data\":[{\"id\":\"1\",\"employee_name\":\"Tiger Nixon\",\"employee_salary\":\"320800\",\"employee_age\":\"61\",\"profile_image\":\"\"},{\"id\":\"2\",\"employee_name\":\"Mathew Murdock\",\"employee_salary\":\"123121\",\"employee_age\":\"34\",\"profile_image\":\"\"},{\"id\":\"3\",\"employee_name\":\"Dany Rand\",\"employee_salary\":\"23423\",\"employee_age\":\"23\",\"profile_image\":\"\"}]}"
            
            let jsonObject = try! JSONSerialization.jsonObject(with: employeeJson.data(using: .utf8)!, options: []) as! [String: Any]
            let employeeObjects = jsonObject["data"] as! [[String: Any]]
            var employees = [Employee]()
            for employeeObject in employeeObjects {
                guard let employeeJSONData = try? JSONSerialization.data(withJSONObject: employeeObject, options: []),
                    let employee = try? JSONDecoder().decode(EmployeeImplementation.self, from: employeeJSONData) else {
                        return
                }
                employees.append(employee)
            }
            presenter.didFetch(employees: employees)
        }
    }
}

class JTEmployeeListViewMock: JTEmployeeListView {
    var presenter: JTEmployeeListPresenter?
    var employees: [Employee]?
    
    func show(employees: [Employee]) {
        self.employees = employees
    }
    
    func showNoEmployeesFound(message: String) {
        
    }
    
    func showError(message: String) {
        
    }
    
    func enableMoreIncomingEmployees() {
        
    }
    
    func disableMoreIncomingEmployees() {
        
    }
    
    func showIndicator() {
        
    }
    
    func hideIndicator() {
        
    }
}

class JTEmployeeListPresenterTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRecordDeletion(){
        // Given
        let interactor = JTEmployeeListInteractorMock()
        let presenter = JTEmployeeListPresenterImplementation()
        presenter.interactor = interactor
        interactor.presenter = presenter
        let view = JTEmployeeListViewMock()
        presenter.view = view
        presenter.viewDidLoad()
        
        XCTAssertNotNil(view.employees)
        XCTAssertEqual(view.employees?.count, 3)
        
        var employees = view.employees
        var employee1 = employees?.first
        XCTAssertEqual(employee1?.id, "1")
        XCTAssertEqual(employee1?.name, "Tiger Nixon")
        XCTAssertEqual(employee1?.age, 61)
        XCTAssertEqual(employee1?.salary, 320800)
        
        var employee2 = employees?[1]
        XCTAssertEqual(employee2?.id, "2")
        XCTAssertEqual(employee2?.name, "Mathew Murdock")
        XCTAssertEqual(employee2?.age, 34)
        XCTAssertEqual(employee2?.salary, 123121)
        
        let employee3 = employees?[2]
        XCTAssertEqual(employee3?.id, "3")
        XCTAssertEqual(employee3?.name, "Dany Rand")
        XCTAssertEqual(employee3?.age, 23)
        XCTAssertEqual(employee3?.salary, 23423)
        
        
        // When
        presenter.deleteRecordAt(index: 1)
        
        // Then
        XCTAssertNotNil(view.employees)
        XCTAssertEqual(view.employees?.count, 2)
        
        employees = view.employees
        employee1 = employees?.first
        XCTAssertEqual(employee1?.id, "1")
        XCTAssertEqual(employee1?.name, "Tiger Nixon")
        XCTAssertEqual(employee1?.age, 61)
        XCTAssertEqual(employee1?.salary, 320800)
        
        employee2 = employees?[1]
        XCTAssertEqual(employee2?.id, "3")
        XCTAssertEqual(employee2?.name, "Dany Rand")
        XCTAssertEqual(employee2?.age, 23)
        XCTAssertEqual(employee2?.salary, 23423)
    }

}
