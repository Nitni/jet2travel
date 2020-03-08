//
//  JTIndicatorView.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 06/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

/// Indicator custom view class. Used to show the activity indicator with message across the application
class JTIndicatorView: JTBaseView {
    
    // MARK: - Variables
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    @IBOutlet private weak var messageLabel: UILabel!
    
    // MARK: - Public methods
    
    /**
        Show activity indicator with message on current page.
     
        - Parameters:
            - message: Message to be dispayed along with indicator
            - view: View instance of source page where indicator needs to be dispayed
     */
    static func showIndicator(with message: String, in view: UIView) -> JTIndicatorView? {
        if let indicatorView = self.fromXib() as? JTIndicatorView {
            AppUtil.setFitConstraints(for: indicatorView, with: view)
            indicatorView.messageLabel.text = message
            indicatorView.indicator.isHidden = false
            indicatorView.indicator.startAnimating()
            return indicatorView
        }
        return nil
    }
    
    /**
        Hides the indicator from current page
     */
    func hideIndicator(){
        self.removeFromSuperview()
    }

}
