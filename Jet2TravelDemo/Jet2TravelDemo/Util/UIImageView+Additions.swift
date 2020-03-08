//
//  UIImageView+Additions.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 07/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

/// UIImageView helper methods
extension UIImageView {
    
    /**
        Download remote image from url.
        - Parameter url: Url to be used to download image data
     */
    func downloadImage(with url: String){
        if !url.isEmpty {
            let requestManager = RequestManagerImplementation(urlSession: URLSession.shared, responseParser: JTResponseParserImplementation())
            requestManager.downloadImage(with: url) { [weak self] (data, response, error)  in
                DispatchQueue.main.async {
                    if let weakSelf = self {
                        if let data = data {
                            weakSelf.image = UIImage(data: data)
                        }else{
                            weakSelf.image = UIImage(named: Constants.Image.UserPlaceholder)
                        }
                    }
                }
            }
        }else{
            self.image = UIImage(named: Constants.Image.UserPlaceholder)
        }
    }
    
    /// Make imae circular with black border of thickness 1 pixel.
    func circularBlackBorder(){
        self.layer.cornerRadius = self.frame.size.width/2
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
    }
}
