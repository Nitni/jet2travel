//
//  JTEmployeeDetailsProtocols.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 07/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

protocol JTEmployeeDetailsView: class {
    var presenter: JTEmployeeDetailsPresenter? {get set}
    
    func show(profileImage: String)
    func showPlaceholderProfileImage()
    func show(nameAge: String)
    func show(salary: String)
}

protocol JTEmployeeDetailsPresenter: class {
    var view: JTEmployeeDetailsView? {get set}
    var employee: Employee? {get set}
    
    func viewDidLoad()
    func back()
}

protocol JTEmployeeDetailsRouter: class {
    
    static func moveBack()
}
