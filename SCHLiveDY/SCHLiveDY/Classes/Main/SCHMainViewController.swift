//
//  SCHMainViewController.swift
//  SCHLiveDY
//
//  Created by Mike on 2018/1/25.
//  Copyright © 2018年 Mike. All rights reserved.
//

import UIKit

class SCHMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.childVc(name: "Home")
        self.childVc(name: "Live")
        self.childVc(name: "Profile")
        self.childVc(name: "Follow")
        
        
    }
    
    private func childVc(name:String){
        //1.通过storyboard获取控制器
        let childVC = UIStoryboard.init(name:name, bundle: nil).instantiateInitialViewController()
        
        //2.将childVc作为子控制器
        addChildViewController(childVC!)
    }
    

}
