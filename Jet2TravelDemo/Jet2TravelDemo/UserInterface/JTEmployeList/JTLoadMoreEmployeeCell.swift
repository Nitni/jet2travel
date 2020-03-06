//
//  JTLoadMoreEmployeeCell.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 07/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

class JTLoadMoreEmployeeCell: UITableViewCell {
    
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    @IBOutlet private weak var messageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.indicator.startAnimating()
        self.messageLabel.text = NSLocalizedString("LoadMoreRecords", comment: "")
    }
    
}
