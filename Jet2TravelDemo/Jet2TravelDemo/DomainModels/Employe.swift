//
//  Employe.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 06/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import Foundation

protocol Employee: Decodable {
    var name: String? {get set}
    var image: String? {get set}
    var salary: Decimal? {get set}
    var age: Int? {get set}
}

struct EmployeeImplementation: Employee {
    var name: String?
    var image: String?
    var salary: Decimal?
    var age: Int?
}
