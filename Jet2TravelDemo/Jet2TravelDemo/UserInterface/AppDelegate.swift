//
//  AppDelegate.swift
//  Jet2TravelDemo
//
//  Created by Nitin Manghwani on 05/03/20.
//  Copyright © 2020 Nitin Manghwani. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var navigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if let employeeListController = JTEmployeeListRouterImplementation.createModule() as? JTEmployeeListViewController {
            self.navigationController = UINavigationController(rootViewController: employeeListController)
            self.navigationController?.isNavigationBarHidden = true
            self.window?.rootViewController = self.navigationController
            self.window?.makeKeyAndVisible()
        }
        return true
    }
    
    static func shared() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }

}

