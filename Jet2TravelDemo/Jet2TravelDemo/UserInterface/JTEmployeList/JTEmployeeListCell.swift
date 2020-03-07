//
//  JTEmployeeListCell.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 07/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

typealias DeletionBlock = (Employee) -> Void

class JTEmployeeListCell: UITableViewCell {
    
    @IBOutlet private weak var employeeProfileImageView: UIImageView!
    @IBOutlet private weak var employeeNameLabel: UILabel!
    private var employee: Employee?
    var deletionBlock: DeletionBlock?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.employeeProfileImageView.circularBlackBorder()
    }

    func setupUI(with employee: Employee){
        self.employee = employee
        self.employeeNameLabel.text = employee.name ?? ""
        if let profileImageURL = employee.image, !profileImageURL.isEmpty {
            self.employeeProfileImageView.downloadImage(with: profileImageURL)
        }else{
            self.employeeProfileImageView.image = UIImage(named: Constants.Image.UserPlaceholder)
        }
    }
    
    @IBAction private func delete(){
        if let deletionBlock = self.deletionBlock, let employee = self.employee {
            deletionBlock(employee)
        }
    }
    
}
