//
//  RequestManager.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 05/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import Foundation

typealias ResponseBlock = (NSDictionary?, NSError?)-> Void
typealias ImageDownloadBlock = (Data?, URLResponse?, NSError?) -> Void

/**
 HTTP requests wrapper. Every HTTP API request needs to go through this interface.
 */
protocol RequestManager {
    
    /**
        Wrapper method for GET HTTP request.
        - Parameters:
            - url: Request url
            - responseBlock: Function block for sending reponse back to source class.
     */
    func get(url: String, responseBlock: @escaping ResponseBlock)
    
    /**
       Wrapper method to download image data
       - Parameters:
           - url: Request url
           - completionBlock: Function block for sending reponse back to source class.
    */
    func downloadImage(with url: String, completionBlock: @escaping ImageDownloadBlock)
}

/// Request manager implementation
class RequestManagerImplementation: RequestManager {
    
    // MARK: - Variables
    private var urlSession: URLSession
    private var responseParser: JTResponseParser
    
    // MARK: - Public methods
    
    /**
     Designated initialiser
     
     - Parameters:
        - urlSession: URLSession instance used to make HTTP request.
        - reponseParser: Parser class instance that will be used to parse the response
     
     */
    init(urlSession: URLSession, responseParser: JTResponseParser) {
        self.urlSession = urlSession
        self.responseParser = responseParser
    }
    
    func get(url: String, responseBlock: @escaping ResponseBlock) {
        
        self.startDataTask(with: url) { (data, response, error) in
            if let error = error{
                responseBlock(nil, error)
            } else{
                self.responseParser.parse(data: data, response: response, error: error as NSError?, responseBlock: responseBlock)
            }
        }
    }
    
    func downloadImage(with url: String, completionBlock: @escaping ImageDownloadBlock) {
        self.startDataTask(with: url) { (data, response, error) in
            completionBlock(data, response, error)
        }
    }
    
    // MARK: - Private methods
    private func startDataTask(with url: String,
                               completionBlock: @escaping (Data?, URLResponse?, NSError?) -> Void){
        guard let url = URL(string: url) else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: Constants.ErrorMessages.InvalidUrl])
            completionBlock(nil, nil, error)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = Constants.API.Get
        let task = self.urlSession.dataTask(with: request) { (data, response, error) in
            completionBlock(data, response, error as NSError?)
        }
        task.resume()
    }
    
}
