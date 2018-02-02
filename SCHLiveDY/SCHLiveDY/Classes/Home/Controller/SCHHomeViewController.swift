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

    //MARK -- 懒加载pageTitleView
    private lazy var pageTitleArr = ["推荐","游戏","娱乐","趣玩"]
    
    private lazy var pageTitleView : SCHPageTitleView = {[weak self] in
        let titleFrame = CGRect(x:0 , y: SCHStatusBarH + SCHNavigationBarH ,width:SCHKscreenW ,height: HPageTitleH)
        let pageTitleView = SCHPageTitleView(frame: titleFrame, titles: pageTitleArr)
        pageTitleView.delegate = self
        return pageTitleView
    }()

    //MARK --- 懒加载pageContentView
    private lazy var pageContentView:SCHPageContentView = {[weak self] in
        let contentFrameH = SCHKscreenH - SCHStatusBarH-SCHNavigationBarH-HPageTitleH
        let contentFrame = CGRect(x: 0, y: SCHStatusBarH+SCHNavigationBarH+HPageTitleH, width: SCHKscreenW, height: contentFrameH)
        let pageContentView = SCHPageContentView(frame: contentFrame, childNumber: pageTitleArr.count, parentViewController: self)
        pageContentView.delegate = self
        return pageContentView
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
        
        //3.pageContentView
        view.addSubview(pageContentView)
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

//MARK -- 遵守SCHPageTitleViewDelegate
extension SCHHomeViewController:SCHPageTitleViewDelegate {
    func pageTitleView(titleView: SCHPageTitleView, selectedIndex index: Int) {
        //调用pageContentView 暴露的方法
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

//MARK -- 遵守SCHPageContentViewDelegate
extension SCHHomeViewController:SCHPageContentViewDelegate{
    func pagecontentView(contentView: SCHPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        //调用pageTitleView 暴露的方法
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
