//
//  JEEmployeeListServiceTests.swift
//  Jet2TravelDemoTests
//
//  Created by Nitin Manghwani on 06/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import XCTest
@testable import Jet2TravelDemo

enum TestCase {
    case None
    case InvalidURL
    case NoResponseDataFound
    case InvalidJSONResponse
    case InvalidResponseDataFormat
    case ValidResponse
    case FailedResponse
}

class URLSessionMock: URLSession {
    
    var testCase = TestCase.None
    init(testCase: TestCase) {
        self.testCase = testCase
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        switch self.testCase {
            case .InvalidURL:
                break
            case .NoResponseDataFound:
                completionHandler(nil, nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: Constants.ErrorMessages.NoResponseData]))
            case .InvalidJSONResponse:
                completionHandler("Non json response".data(using: String.Encoding.utf8), nil, nil)
            case .InvalidResponseDataFormat:
                completionHandler("{\"status\":\"success\",\"data\":\"\"}".data(using: String.Encoding.utf8), nil, nil)
            case .ValidResponse:
                completionHandler("{\"status\":\"success\",\"data\":[{\"id\":\"1\",\"employee_name\":\"Tiger Nixon\",\"employee_salary\":\"320800\",\"employee_age\":\"61\",\"profile_image\":\"\"}]}".data(using: String.Encoding.utf8), nil, nil)
            case .FailedResponse:
            completionHandler("{\"status\":\"failed\",\"data\":[{\"id\":\"1\",\"employee_name\":\"Tiger Nixon\",\"employee_salary\":\"320800\",\"employee_age\":\"61\",\"profile_image\":\"\"}]}".data(using: String.Encoding.utf8), nil, nil)
            case .None:
                break
            
            }
        return URLSessionDataTask()
    }
}


class JEEmployeeListServiceTests: XCTestCase {
    
    var testCase = TestCase.None

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInvalidURL(){
        let requestManager = RequestManagerImplementation(urlSession: URLSessionMock(testCase: .InvalidURL), responseParser: JTResponseParserImplementation())
        let service = JTEmployeeServiceImplementation(requestManager: requestManager)
        service.getEmployees { (employees, error) in
            XCTAssertNil(employees)
            XCTAssertEqual(error?.localizedDescription, Constants.ErrorMessages.InvalidUrl)
        }
    }
    
    func testNoResponseDataFound(){
        let requestManager = RequestManagerImplementation(urlSession: URLSessionMock(testCase: .NoResponseDataFound), responseParser: JTResponseParserImplementation())
        let service = JTEmployeeServiceImplementation(requestManager: requestManager)
        service.getEmployees { (employees, error) in
            XCTAssertNil(employees)
            XCTAssertEqual(error?.localizedDescription, Constants.ErrorMessages.NoResponseData)
        }
    }
    
    func testInvalidJSONResponse(){
        let requestManager = RequestManagerImplementation(urlSession: URLSessionMock(testCase: .InvalidJSONResponse), responseParser: JTResponseParserImplementation())
        let service = JTEmployeeServiceImplementation(requestManager: requestManager)
        service.getEmployees { (employees, error) in
            XCTAssertNil(employees)
            XCTAssertEqual(error?.localizedDescription, Constants.ErrorMessages.InvalidJsonResponse)
        }
    }
    
    func testInvalidResponseDataFormat(){
        let requestManager = RequestManagerImplementation(urlSession: URLSessionMock(testCase: .InvalidResponseDataFormat), responseParser: JTResponseParserImplementation())
        let service = JTEmployeeServiceImplementation(requestManager: requestManager)
        service.getEmployees { (employees, error) in
            XCTAssertNil(employees)
            XCTAssertEqual(error?.localizedDescription, Constants.ErrorMessages.InvalidResponseDataFormat)
        }
    }
    
    func testFailedResponse(){
        let requestManager = RequestManagerImplementation(urlSession: URLSessionMock(testCase: .FailedResponse), responseParser: JTResponseParserImplementation())
        let service = JTEmployeeServiceImplementation(requestManager: requestManager)
        service.getEmployees { (employees, error) in
            XCTAssertNil(employees)
            XCTAssertEqual(error?.localizedDescription, Constants.ErrorMessages.FailedResponse)
        }
    }
    
    func testValidResponse() {
        let requestManager = RequestManagerImplementation(urlSession: URLSessionMock(testCase: .ValidResponse), responseParser: JTResponseParserImplementation())
        let service = JTEmployeeServiceImplementation(requestManager: requestManager)
        service.getEmployees { (employees, error) in
            XCTAssertNil(error)
            XCTAssertEqual(employees?.count, 1)
        }
    }
}
