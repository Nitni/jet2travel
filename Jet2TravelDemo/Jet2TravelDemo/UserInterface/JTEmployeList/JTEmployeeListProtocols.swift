//
//  JTEmployeeListProtocols.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 05/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

/// View protocol for employee list page
protocol JTEmployeeListView: class {
    
    // MARK: - Variables
    var presenter: JTEmployeeListPresenter? {get set}
    
    // MARK: - Methods
    
    /**
        Show list of employees retured by API. To be called by presenter class.
     
        - Parameter employees: Array containing employee objects to display in employee list.
     */
    func show(employees: [Employee])
    
    /**
        Show no employees found message in case there are no anty employess returned by API. To be called by presenter class.
            
        - Parameter message: Message to be shown on screen.
     */
    func showNoEmployeesFound(message: String)
    
    /**
       Show error message on screen for any kind of error occured. For e.g. no internet connection. To be called by presenter class.
           
       - Parameter message: Error message to be shown on screen.
    */
    func showError(message: String)
    
    /**
        Indicate wheter where have more incoming records from API, so show the load more records message at the bottom of the page when user reaches to the end of records.
        This method is used when pagination is supported by API.
     */
    func enableMoreIncomingEmployees()
    
    /**
        No more employess records are pending to be shown. We have reached to the end of record list.
     */
    func disableMoreIncomingEmployees()
    
    /// Show activity indicator on screen.
    func showIndicator()
    
    /// Hide activity indicator from the screen.
    func hideIndicator()
    
    /**
       Enable/Disable sorting on list page. To be called by presenter class.
           
       - Parameter enabled: Flag indicating sorting to be enalbed or disabled.
    */
    func sorting(enabled: Bool)
}

protocol JTEmployeeListPresenter: class {
    
    // MARK: - Variables
    var view: JTEmployeeListView? {get set}
    var interactor: JTEmployeeListInteractor? {get set}
    
    // MARK: - Methods
    
    /// Called by view class to notify presenter class that view is loaded into memory and ready for further steps.
    func viewDidLoad()
    
    /// Refresh employee list. Called by view class to notify refresh event from user.
    func refreshEmployeeList()
    
    /**
        Called by view class to notify that user has reached the end of record list and needs to load records from next page.
        This method is useful while pagination is supported
     */
    func loadMoreEmployees()
    
    /**
        Called by view class to notify that user has selected particular record.
     
        - Parameter index: Record index selected by user.
     */
    func recordDidSelected(index: Int)
    
    /**
       Called by view class to notify that user has selected to delete the particular record.
    
       - Parameter index: Record index selected by user.
    */
    func deleteRecordAt(index: Int)
    
    /**
       Called by interactor class to notify that employe list fetch is successfully completed from API.
    
       - Parameter employees: List of employess fetched from API.
    */
    func didFetch(employees: [Employee])
    
    /**
       Called by interactor class to notify that employe list fetch failed with error.
    
       - Parameter error: Error occured while fetching employee list from API.
    */
    func employeesFetchFailed(with error: NSError)
    
    /// Called by view class to notify that user has selected to sort the record list by name.
    func sortByName()
    
    /// Called by view class to notify that user has selected to sort the record list by age.
    func sortByAge()
}

protocol JTEmployeeListInteractor: class {
    
    // MARK: - Variables
    var presenter: JTEmployeeListPresenter? {get set}
    var service: JTEmployeeService? {get set}
    
    // MARK: - Methods
    
    /**
        Called by presenter class to notify to start fetchng employee list from API.
     
        - Parameter pageNumber: Page number for which list to be fetched. This is used if pagination is supported
     */
    func fetchEmployees(for pageNumber: Int)
}

protocol JTEmployeeListRouter: class {
    
    /**
        Contains initialisation logic for view, presenter and interactor classes.
     
        - Returns: Instance of employee list page view.
     */
    static func createModule() -> JTEmployeeListView?
    
    /**
        Show employee detail page.
     
        - Parameter employeeDetail: Employee data model contains employee details to be displayed on page.
     */
    static func show(employeeDetail: Employee)
}
