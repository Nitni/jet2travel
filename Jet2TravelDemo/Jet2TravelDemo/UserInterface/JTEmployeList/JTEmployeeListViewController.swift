//
//  JTEmployeeListViewController.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 05/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

/// Constants used in this source file
private enum ViewConstants {
    static let EmployeeListCellNib = "JTEmployeeListCell"
    static let LoadMoreEmployeesNib = "JTLoadMoreEmployeeCell"
    static let NoEmployeesFoundCellNib = "JTNoEmployeesFoundCell"
    static let FetchingEmployessKey = "FetchingEmployees"
    static let ScreenTitleLocalisedKey = "EmployeeListTitle"
    static let DeleteRecordConfirmationKey = "DeleteRecordConfirmation"
    static let SortButtonTitleLocalisedKey = "Sort"
    static let SortOptionTitleLocaliseKey = "SortBy"
    static let SortByNameLocalisedKey = "SortByName"
    static let SortByAgeLocalisedKey = "SortByAge"
}

/// View controller  class for employee list
class JTEmployeeListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var screenTitleLabel: UILabel!
    @IBOutlet private weak var sortButton: UIButton!
    @IBOutlet private weak var employeeList: UITableView!
    
    // MARK: - Variables
    private weak var indicator: JTIndicatorView?
    private let refreshControler = UIRefreshControl()
    private var employees: [Employee]?
    private var moreEmployeesIncoming = false
    var presenter: JTEmployeeListPresenter?
    
    // MARK: - Life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        if let presenter = self.presenter {
            presenter.viewDidLoad()
        }
        self.setupUI()
    }
    
    // MARK: - Private methods
    
    /// Method used to do initial UI setup for page.
    private func setupUI(){
        self.screenTitleLabel.text = NSLocalizedString(ViewConstants.ScreenTitleLocalisedKey, comment: "")
        self.sortButton.setTitle(NSLocalizedString(ViewConstants.SortButtonTitleLocalisedKey, comment: ""), for: .normal)
        let employeeListCellNib = UINib(nibName: ViewConstants.EmployeeListCellNib, bundle: nil)
        self.employeeList.register(employeeListCellNib, forCellReuseIdentifier: ViewConstants.EmployeeListCellNib)
        let loadMoreCellNib = UINib(nibName: ViewConstants.LoadMoreEmployeesNib, bundle: nil)
        self.employeeList.register(loadMoreCellNib, forCellReuseIdentifier: ViewConstants.LoadMoreEmployeesNib)
        let noEmployeesFoundCellNib = UINib(nibName: ViewConstants.NoEmployeesFoundCellNib, bundle: nil)
        self.employeeList.register(noEmployeesFoundCellNib, forCellReuseIdentifier: ViewConstants.NoEmployeesFoundCellNib)
        self.refreshControler.addTarget(self, action: #selector(refreshEmployeeList), for: .valueChanged)
        self.employeeList.addSubview(self.refreshControler)
    }
    
    @objc private func refreshEmployeeList(){
        if let presenter = self.presenter {
            presenter.refreshEmployeeList()
        }
    }
    
    @IBAction private func sortButtonClicked(){
        guard let presenter = self.presenter else {
            return
        }
        let sortByNameAction = JTActionModel(title: NSLocalizedString(ViewConstants.SortByNameLocalisedKey, comment: "")) { () -> Void? in
            presenter.sortByName()
        }
        let sortByAgeAction = JTActionModel(title: NSLocalizedString(ViewConstants.SortByAgeLocalisedKey, comment: "")) { () -> Void? in
            presenter.sortByAge()
        }
        JTAlertUtility.showActiomsheet(with: NSLocalizedString(ViewConstants.SortOptionTitleLocaliseKey, comment: ""), actions: [sortByNameAction, sortByAgeAction], in: self)
    }
}

/// View implementation for employee list
extension JTEmployeeListViewController: JTEmployeeListView{
    
    func show(employees: [Employee]) {
        self.employees = employees
        DispatchQueue.main.async {
            self.employeeList.isHidden = false
            self.refreshControler.endRefreshing()
            self.employeeList.reloadData()
        }
    }
    
    func showNoEmployeesFound(message: String) {
        DispatchQueue.main.async {
            self.refreshControler.endRefreshing()
            self.employeeList.reloadData()
        }

    }
    
    func showError(message: String) {
        DispatchQueue.main.async {
            self.refreshControler.endRefreshing()
            JTAlertUtility.showAlert(with: message, delay: .now() + 0.3, type: .single, okClickHandler: nil, in: self)
        }
        
    }
    
    func enableMoreIncomingEmployees() {
        self.moreEmployeesIncoming = true
    }
    
    func disableMoreIncomingEmployees() {
        self.moreEmployeesIncoming = false
    }
    
    func showIndicator(){
        DispatchQueue.main.async {
            self.indicator = JTIndicatorView.showIndicator(with: NSLocalizedString(ViewConstants.FetchingEmployessKey, comment: ""), in: self.view)
        }
    }
    
    func hideIndicator(){
        DispatchQueue.main.async {
            if let indicator = self.indicator {
                indicator.hideIndicator()
            }
        }
    }
    
    func sorting(enabled: Bool) {
        DispatchQueue.main.async {
            self.sortButton.isEnabled = enabled
        }
        
    }
}

/// UITableViewDelegate extension
extension JTEmployeeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let presenter = self.presenter {
            presenter.recordDidSelected(index: indexPath.row)
        }
    }
}

/// UITableViewDataSource extension
extension JTEmployeeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let employees = self.employees else {
            return 1
        }
        return self.moreEmployeesIncoming ? employees.count + 1 : employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Return no employees found message cell if there are no employees
        guard let employees = self.employees else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ViewConstants.NoEmployeesFoundCellNib) as? JTNoEmployeesFoundCell else {
                return UITableViewCell()
            }
            return cell
        }
        
        // Check if we haven't got all the records and we have more records coming from API.
        if self.moreEmployeesIncoming, indexPath.row == employees.count {
            // If yes than display load more message cell at the end of list while more records are loaded via API.
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ViewConstants.LoadMoreEmployeesNib) as? JTLoadMoreEmployeeCell else {
                return UITableViewCell()
            }
            if let presenter = self.presenter {
                presenter.loadMoreEmployees()
            }
            return cell
        }else {
            // Otherwise keep displaying cell with employee data.
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ViewConstants.EmployeeListCellNib) as? JTEmployeeListCell else {
                return UITableViewCell()
            }
            cell.setupUI(with: employees[indexPath.row])
            cell.deletionBlock = { employee in
                JTAlertUtility.showDoubleActionAlert(with: ViewConstants.DeleteRecordConfirmationKey, okClickHandler: { [weak self] in
                    if let weakSelf = self, let presenter = weakSelf.presenter {
                        presenter.deleteRecordAt(index: indexPath.row)
                    }
                }, in: self)
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
}
