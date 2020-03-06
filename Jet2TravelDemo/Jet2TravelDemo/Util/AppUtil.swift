//
//  AppUtil.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 06/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

class AppUtil {
    static func setFitConstraints(for subView: UIView, with superView:UIView){
        superView.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
        subView.leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        subView.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        subView.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
}
