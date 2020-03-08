//
//  JTResponseParser.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 06/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import Foundation

/// Response parser implementation for HTTP services
protocol JTResponseParser {
    
    /**
    Parse service response and send back to calling method using function block.
     
     - Parameters:
        - data: Raw bytes of response data.
        - response: URLResponse instance containing response details.
        - error:Error details in case of any error.
        - responseBlock: Function block used to send parsed response back to calling code.
     */
    func parse(data: Data?, response: URLResponse?, error: NSError?, responseBlock: @escaping ResponseBlock)
}

class JTResponseParserImplementation: JTResponseParser {
    
    // MARK: - Public methods
    func parse(data: Data?, response: URLResponse?, error: NSError?, responseBlock: @escaping ResponseBlock) {
        guard let data = data else {
            self.sendError(with: Constants.ErrorMessages.NoResponseData, responseBlock: responseBlock)
            return
        }
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
                self.sendError(with: Constants.ErrorMessages.InvalidJsonResponse, responseBlock: responseBlock)
                return
            }
            responseBlock(json, nil)
        } catch _ {
            self.sendError(with: Constants.ErrorMessages.InvalidJsonResponse, responseBlock: responseBlock)
            return
        }
    }
    
    // MARK: - Private methods
    private func sendError(with message: String, responseBlock: @escaping ResponseBlock){
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
        responseBlock(nil, error)
    }
}
