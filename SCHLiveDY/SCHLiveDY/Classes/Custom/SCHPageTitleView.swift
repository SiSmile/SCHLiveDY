//
//  SCHPageTitleView.swift
//  SCHLiveDY
//
//  Created by Mike on 2018/2/1.
//  Copyright © 2018年 Mike. All rights reserved.
//

import UIKit
private let HscrollLineH:CGFloat = 2
class SCHPageTitleView: UIView {
    //mark -- 定义属性 数组
    private var titles :[String]
    
    //Mark --- 懒加载数组 存放labels
    private lazy var titlesLabels:[UILabel] = [UILabel]()
    
    //Mark --- 懒加载scrollerView
    private lazy var scrollerView:UIScrollView = {
       let scrollerView = UIScrollView()
        scrollerView.frame = bounds
        scrollerView.showsVerticalScrollIndicator = false
        scrollerView.scrollsToTop = false
        scrollerView.isPagingEnabled = false
        scrollerView.bounces = false
        return scrollerView
    }()
    
    //Mark --- 懒加载scrollerLine
    private lazy var scrollerLine:UIView = {
        let scrollerLine = UIView()
        scrollerLine.backgroundColor = UIColor.orange
        return scrollerLine
    }()
    
    
    //MARK --- 自定义构造函数
    init(frame:CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        
        //设置UI界面
        setPageUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
}
extension SCHPageTitleView {
    private func setPageUI() {
        //1.添加scrollView
        addSubview(scrollerView)
        
        //2.添加对应的lable
        setTitleLabel()
        
        //3.设置底线和滑动的滑块
        setBottomLineAndScrollerLine()
    }
    private func setTitleLabel(){
        
        let labelW:CGFloat = frame.width / CGFloat(titles.count)
        let labelH:CGFloat = frame.height - HscrollLineH
        let labelY:CGFloat = 0
        for (index, title) in titles.enumerated() {
            //1.创建label
            let label = UILabel()
            
            //2.设置label属性
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.darkGray;
            label.textAlignment = NSTextAlignment.center;
            label.text = title
            
            //3.设置frame
            let labelX:CGFloat = labelW * (CGFloat(index))
            label.frame = CGRect(x:labelX,y:labelY,width:labelW,height:labelH)
            
            //4.将label添加到scrollView中
            scrollerView.addSubview(label)
            titlesLabels.append(label)
            
        }
    }
    
    private func setBottomLineAndScrollerLine(){
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH:CGFloat = 0.5
        
        bottomLine.frame = CGRect(x:0,y:frame.height-lineH,width:frame.width,height:lineH)
        addSubview(bottomLine)
        
        //2.添加scollerLine
         //2.1获取第一个label
        guard let firstLabel = titlesLabels.first else {return}
        firstLabel.textColor = UIColor.orange
        scrollerView.addSubview(scrollerLine)
        scrollerLine.frame = CGRect(x:firstLabel.frame.origin.x,y:frame.height-HscrollLineH,width:firstLabel.frame.width,height:HscrollLineH)
        
    }
}
