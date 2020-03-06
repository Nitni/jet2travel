//
//  JTEmployeeListViewController.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 05/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

class JTEmployeeListViewController: UIViewController {
    
    var presenter: JTEmployeeListPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension JTEmployeeListViewController: JTEmployeeListView{
    
    
    func show(employess: [Employee]) {
        
    }
    
    func showMore(employees: [Employee]) {
        
    }
    
    func showNoEmployeesFound(message: String) {
        
    }
    
    func showError(message: String) {
        
    }
    
    
}
