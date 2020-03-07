//
//  JTEmployeeDetailsViewController.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 07/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

private enum ViewConstants {
    static let EmployeeListCellNib = "JTEmployeeListCell"
    static let LoadMoreEmployeesNib = "JTLoadMoreEmployeeCell"
    static let NoEmployeesFoundCellNib = "JTNoEmployeesFoundCell"
    static let FetchingEmployessKey = "FetchingEmployees"
    static let ScreenTitleLocalisedKey = "EmployeeDetailsTitle"
}

class JTEmployeeDetailsViewController: UIViewController {
    
    var presenter: JTEmployeeDetailsPresenter?
    
    @IBOutlet private weak var screenTitleLabel: UILabel!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nameAgeLabel: UILabel!
    @IBOutlet private weak var salaryLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let presenter = self.presenter {
            presenter.viewDidLoad()
        }
        self.setupUI()
    }
    
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
