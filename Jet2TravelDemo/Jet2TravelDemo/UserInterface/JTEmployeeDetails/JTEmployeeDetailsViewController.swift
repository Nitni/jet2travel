//
//  JTEmployeeDetailsViewController.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 07/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

/// Constants used in this source file
private enum ViewConstants {
    static let EmployeeListCellNib = "JTEmployeeListCell"
    static let LoadMoreEmployeesNib = "JTLoadMoreEmployeeCell"
    static let NoEmployeesFoundCellNib = "JTNoEmployeesFoundCell"
    static let FetchingEmployessKey = "FetchingEmployees"
    static let ScreenTitleLocalisedKey = "EmployeeDetailsTitle"
}

/// View controller class for employee details page
class JTEmployeeDetailsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var screenTitleLabel: UILabel!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nameAgeLabel: UILabel!
    @IBOutlet private weak var salaryLabel: UILabel!
    
    // MARK: - Variables
    var presenter: JTEmployeeDetailsPresenter?
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        if let presenter = self.presenter {
            presenter.viewDidLoad()
        }
        self.setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI(){
        self.screenTitleLabel.text = NSLocalizedString(ViewConstants.ScreenTitleLocalisedKey, comment: "")
        self.profileImageView.circularBlackBorder()
    }
    
    @IBAction private func back(){
        if let presenter = self.presenter {
            presenter.back()
        }
    }
}

/// View implementation for employee details page
extension JTEmployeeDetailsViewController: JTEmployeeDetailsView {
    
    func show(profileImage: String){
        self.profileImageView.downloadImage(with: profileImage)
    }
    
    func showPlaceholderProfileImage(){
        self.profileImageView.image = UIImage(named: Constants.Image.UserPlaceholder)
    }
    
    func show(nameAge: String){
        self.nameAgeLabel.text = nameAge
    }
    
    func show(salary: String){
        self.salaryLabel.text = salary
    }
    
}
