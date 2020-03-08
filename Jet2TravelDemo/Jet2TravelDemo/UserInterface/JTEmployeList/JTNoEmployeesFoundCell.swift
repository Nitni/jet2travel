//
//  JTNoEmployeesFoundCell.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 07/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

/// Custom UITableViewCell class to show no employees found message in case there are no employees.
class JTNoEmployeesFoundCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var messageLabel: UILabel!

    // MARK: - Lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.messageLabel.text = NSLocalizedString("NoEmployeesFound", comment: "")
    }
    
}
