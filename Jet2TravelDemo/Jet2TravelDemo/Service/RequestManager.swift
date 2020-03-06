//
//  RequestManager.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 05/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import Foundation

typealias ResponseBlock = (NSDictionary?, NSError?)-> Void

protocol RequestManager {
    func get(url: String, responseBlock: @escaping ResponseBlock)
}

class RequestManagerImplementation: RequestManager {
    
    private var urlSession: URLSession
    private var responseParser: JTResponseParser
    
    init(urlSession: URLSession, responseParser: JTResponseParser) {
        self.urlSession = urlSession
        self.responseParser = responseParser
    }
    
    func get(url: String, responseBlock: @escaping ResponseBlock) {
        guard let url = URL(string: url) else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: Constants.ErrorMessages.InvalidUrl])
            responseBlock(nil, error)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = Constants.API.Get
        let task = self.urlSession.dataTask(with: request) { (data, response, error) in
            self.responseParser.parse(data: data, response: response, error: error as NSError?, responseBlock: responseBlock)
        }
        task.resume()
    }
    
}
