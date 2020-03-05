//
//  JTEmployeeListProtocols.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 05/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

protocol JTEmployeeListView {
    var presenter: JTEmployeeListPresenter {get set}
}

protocol JTEmployeeListPresenter {
    var view: JTEmployeeListView {get set}
    var interactor: JTEmployeeListInteractor {get set}
}

protocol JTEmployeeListInteractor {
    var presenter: JTEmployeeListPresenter {get set}
}

protocol JTEmployeeListRouter {
    
}
