//
//  AppConstants.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 06/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

struct Constants {
    static let ApplicationName = "Jet2TravelDemo"
    struct ErrorMessages {
        static let InvalidUrl = "Invalid url"
        static let NoResponseData = "No response data found"
        static let InvalidJsonResponse = "Invalid JSON response format"
        static let InvalidResponseDataFormat = "Invalid response data format"
        static let FailedResponse = "Response failure"
    }
    struct API {
        static let Get = "GET"
        static let Post = "POST"
        static let BaseEndpoint = "http://dummy.restapiexample.com/api/v1"
        static let EmployeeListEndpoint = "/employees"
        static let StatusKey = "status"
        static let ResponseDataKey = "data"
    }
    struct Storyboard {
        static let Main = "Main"
    }
    struct Image {
        static let UserPlaceholder = "iconUser"
    }
}
