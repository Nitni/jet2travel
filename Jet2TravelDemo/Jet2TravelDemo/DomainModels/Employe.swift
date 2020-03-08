//
//  Employe.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 06/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import Foundation

/// Interface for employe data model.
protocol Employee: Decodable {
    var id: String? {get set}
    var name: String? {get set}
    var image: String? {get set}
    var salary: Decimal? {get set}
    var age: Int? {get set}
}

/// Employee data model implementation
struct EmployeeImplementation: Employee {
    
    // MARK: - Variables
    var id: String?
    var name: String?
    var image: String?
    var salary: Decimal?
    var age: Int?
    
    private enum CondingKeys: String, CodingKey {
        case id
        case name = "employee_name"
        case image = "profile_image"
        case salary = "employee_salary"
        case age = "employee_age"
    }
    
    // MARK: - Designated initialiser
    init(from decoder:  Decoder) throws {
        let container = try decoder.container(keyedBy: CondingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        let age = try container.decode(String.self, forKey: .age)
        self.age = Int(age)
        self.image = try container.decode(String.self, forKey: .image)
        let salary = try container.decode(String.self, forKey: .salary)
        self.salary = NSDecimalNumber(string: salary) as Decimal
    }
}
