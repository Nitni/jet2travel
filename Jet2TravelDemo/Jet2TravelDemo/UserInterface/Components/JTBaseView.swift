//
//  JTBaseView.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 06/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

/// Class acts a base view for all custom views to be created in application
class JTBaseView: UIView {

    /**
        Method creates the instance of custom view from XIB.
     
        - returns: Instance of custom view
     */
    static func fromXib() -> JTBaseView? {
        guard let view = Bundle.main.loadNibNamed(String(describing: self), owner: self, options: nil)?.first as? JTBaseView else {
            return nil
        }
        return view
    }

}
