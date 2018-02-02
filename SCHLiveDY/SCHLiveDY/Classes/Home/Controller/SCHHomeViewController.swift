//
//  SCHHomeViewController.swift
//  SCHLiveDY
//
//  Created by Mike on 2018/2/1.
//  Copyright © 2018年 Mike. All rights reserved.
//

import UIKit
private let HPageTitleH:CGFloat = 60
class SCHHomeViewController: UIViewController {

    //MARK -- 懒加载pageView
    
    
    private lazy var pageTitleView : SCHPageTitleView = {
        let titleFrame = CGRect(x:0 , y: SCHStatusBarH + SCHNavigationBarH ,width:SCHKscreenW ,height: HPageTitleH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let pageTitleView = SCHPageTitleView(frame: titleFrame, titles: titles)
        return pageTitleView
    }()


    //MARK -- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置ui
        setupUI()
       
    }
    
}
//extension 模块划分
//mark --- 设置ui
extension SCHHomeViewController {
    private func setupUI(){
        automaticallyAdjustsScrollViewInsets = false
        
        //1 设置导航栏
        setNavigationBar()
        
        //2.pageTitleView
        view.addSubview(pageTitleView)
    }
    
    //设置导航栏
    private func setNavigationBar(){
        //1.1 左侧按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        //1.2 右侧按钮
        let size = CGSize(width:40,height:40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
    }
    
    
}
