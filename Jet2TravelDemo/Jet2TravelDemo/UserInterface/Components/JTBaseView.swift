//
//  JTBaseView.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 06/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

class JTBaseView: UIView {

    static func fromXib() -> JTBaseView? {
        guard let view = Bundle.main.loadNibNamed(String(describing: self), owner: self, options: nil)?.first as? JTBaseView else {
            return nil
        }
        return view
    }

}
