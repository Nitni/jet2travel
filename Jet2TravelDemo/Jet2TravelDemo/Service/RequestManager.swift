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
    
    func get(url: String, responseBlock: @escaping ResponseBlock) {
        guard let url = URL(string: url) else {
            self.sendError(with: Constants.ErrorMessages.InvalidUrl, responseBlock: responseBlock)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = Constants.API.Get
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
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
        task.resume()
    }
    
    private func sendError(with message: String, responseBlock: @escaping ResponseBlock){
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
        responseBlock(nil, error)
    }
    
}
