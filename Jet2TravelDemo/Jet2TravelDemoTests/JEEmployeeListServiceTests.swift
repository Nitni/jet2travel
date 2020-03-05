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
}

class RequestManagerMock: RequestManager {
    var testCase = TestCase.None
    init(testCase: TestCase) {
        self.testCase = testCase
    }
    func get(url: String, responseBlock: @escaping ResponseBlock) {
        switch self.testCase {
        case .InvalidURL:
            responseBlock(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: Constants.ErrorMessages.InvalidUrl]))
        case .NoResponseDataFound:
            responseBlock(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: Constants.ErrorMessages.NoResponseData]))
        case .InvalidJSONResponse:
            responseBlock(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: Constants.ErrorMessages.InvalidJsonResponse]))
        case .InvalidResponseDataFormat:
            responseBlock(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: Constants.ErrorMessages.InvalidResponseDataFormat]))
        case .ValidResponse:
            let mockResponse = NSDictionary()
            responseBlock(mockResponse, nil)
        case .None:
            break
        
        }
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
        let requestManager = RequestManagerMock(testCase: .InvalidURL)
        let service = JTEmployeeServiceImplementation(requestManager: requestManager)
        service.getEmployees { (employees, error) in
            XCTAssertNil(employees)
            XCTAssertEqual(error?.localizedDescription, Constants.ErrorMessages.InvalidUrl)
        }
    }
    
    func testNoResponseDataFound(){
    }
    
    func testInvalidJSONResponse(){
    }
    
    func testInvalidResponseDataFormat(){
    }
    
    func testValidResponse() {
    }
}
