//
//  AppDelegate.swift
//  SCHLiveDY
//
//  Created by Mike on 2018/1/25.
//  Copyright © 2018年 Mike. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //修改tabbar
        UITabBar.appearance().tintColor = UIColor.orange
        
        
        return true
    }

    


}

