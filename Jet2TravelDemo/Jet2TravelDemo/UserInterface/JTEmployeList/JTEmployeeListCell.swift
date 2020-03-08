//
//  JTEmployeeListCell.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 07/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

typealias DeletionBlock = (Employee) -> Void

///
/// Custom UITableViewCell class for emplyee list cell.
class JTEmployeeListCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var employeeProfileImageView: UIImageView!
    @IBOutlet private weak var employeeNameLabel: UILabel!
    
    // MARK: - Variables
    private var employee: Employee?
    var deletionBlock: DeletionBlock?
    
    // MARK: - Lifecycle methods

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.employeeProfileImageView.circularBlackBorder()
    }
    
    // MARK: - Public methods
    
    /**
        Method to setup and load UI details for cell.
     
        - Parameter employee: Employee data model containing employee details to display.
     */
    func setupUI(with employee: Employee){
        self.employee = employee
        var nameAge = ""
        if let age = employee.age, age != 0,
            let name = employee.name, !name.isEmpty {
            nameAge = name + ", " + String(age)
        } else if let name = employee.name, !name.isEmpty {
            nameAge = name
        } else if let age = employee.age, age != 0 {
            nameAge = String(age)
        }
        self.employeeNameLabel.text = nameAge
        if let profileImageURL = employee.image, !profileImageURL.isEmpty {
            self.employeeProfileImageView.downloadImage(with: profileImageURL)
        }else{
            self.employeeProfileImageView.image = UIImage(named: Constants.Image.UserPlaceholder)
        }
    }
    
    // MARK: - Private methods
    
    @IBAction private func delete(){
        if let deletionBlock = self.deletionBlock, let employee = self.employee {
            deletionBlock(employee)
        }
    }
    
}
