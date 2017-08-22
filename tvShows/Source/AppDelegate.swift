//
//  AppDelegate.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 20/07/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        guard let window = window else {
            return false
        }
        
        let vc = MainVC(nibName: "MainVC", bundle: nil)
        vc.di = DI.appDependencies
        window.rootViewController = vc
        window.makeKeyAndVisible()
        
        return true
    }
}
