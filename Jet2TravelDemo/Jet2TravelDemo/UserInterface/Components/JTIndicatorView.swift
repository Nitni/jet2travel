//
//  JTIndicatorView.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 06/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

class JTIndicatorView: JTBaseView {
    
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    @IBOutlet private weak var messageLabel: UILabel!
    
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
    
    func hideIndicator(){
        self.removeFromSuperview()
    }

}
