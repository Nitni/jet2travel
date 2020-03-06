//
//  JTEmployeeListCell.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 07/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

class JTEmployeeListCell: UITableViewCell {
    
    @IBOutlet private weak var employeeProfileImageView: UIImageView!
    @IBOutlet private weak var employeeNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.employeeProfileImageView.layer.cornerRadius = self.employeeProfileImageView.frame.size.width/2
    }

    func setupUI(with employee: Employee){
        
        self.employeeNameLabel.text = employee.name ?? ""
        if let profileImageURL = employee.image, !profileImageURL.isEmpty {
            let requestManager = RequestManagerImplementation(urlSession: URLSession.shared, responseParser: JTResponseParserImplementation())
            requestManager.downloadImage(with: profileImageURL) { [weak self] (data, response, error)  in
                DispatchQueue.main.async {
                    if let weakSelf = self {
                        if let data = data {
                            weakSelf.employeeProfileImageView.image = UIImage(data: data)
                        }else{
                            weakSelf.employeeProfileImageView.image = UIImage(named: Constants.Image.UserPlaceholder)
                        }
                    }
                }
            }
        }else{
            self.employeeProfileImageView.image = UIImage(named: Constants.Image.UserPlaceholder)
        }
    }
    
}
