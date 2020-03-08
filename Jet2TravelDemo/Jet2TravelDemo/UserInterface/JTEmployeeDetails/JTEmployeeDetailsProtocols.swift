//
//  JTEmployeeDetailsProtocols.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 07/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

/// View protocol for employee details page
protocol JTEmployeeDetailsView: class {
    
    // MARK: - Variables
    var presenter: JTEmployeeDetailsPresenter? {get set}
    
    // MARK: - Methods
    
    /**
     Called by presenter class to show profile image on employee details page.
     
     - Parameter profileImage: Url to download employee's profile image
     */
    func show(profileImage: String)
    
    /// Called to notify view to show placeholder for profile in case of no profile image present.
    func showPlaceholderProfileImage()
    
    /**
     Show name and age details of employee.
     
     - Parameter nameAge: Formatted string containing name and age of employee to be displayed.
     */
    func show(nameAge: String)
    
    /**
    Show salary details of employee.
    
    - Parameter salary: Formatted string containing salary of employee to be displayed.
    */
    func show(salary: String)
}

protocol JTEmployeeDetailsPresenter: class {
    
    // MARK: - Variables
    var view: JTEmployeeDetailsView? {get set}
    var employee: Employee? {get set}
    
    // MARK: - Methods
    
    /// Called by view class to notify presenter class that view is loaded into memory and ready for further steps.
    func viewDidLoad()
    
    /// Called by view class to notify the back navigation event.
    func back()
}

protocol JTEmployeeDetailsRouter: class {
    
    /// Navigate user to previous screen.
    static func moveBack()
}
