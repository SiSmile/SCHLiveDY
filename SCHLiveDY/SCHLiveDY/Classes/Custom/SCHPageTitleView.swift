//
//  SCHPageTitleView.swift
//  SCHLiveDY
//
//  Created by Mike on 2018/2/1.
//  Copyright © 2018年 Mike. All rights reserved.
//

import UIKit
/*
 定义代理 通知控制器用户点击了pagetitle
 1::class   只能被类遵守
 */
protocol SCHPageTitleViewDelegate:class {
    func pageTitleView(titleView:SCHPageTitleView,selectedIndex index :Int)
}

/*
 定义 常量
 */
private let HscrollLineH:CGFloat = 2
private let NormalColor:(CGFloat,CGFloat,CGFloat) = (85,85,85)
private let SelectColor:(CGFloat,CGFloat,CGFloat) = (255,128,0)

class SCHPageTitleView: UIView {
    //mark -- 定义属性 数组
    private var titles :[String]
    //mark -- 定义属性 当前选中的label
    private var currentIndex :Int = 0
    
    weak var delegate:SCHPageTitleViewDelegate?
    
    
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
            label.textColor = UIColor(r:NormalColor.0,g:NormalColor.1,b:NormalColor.2)
            label.textAlignment = NSTextAlignment.center;
            label.text = title
            label.tag = index
            
            //3.设置frame
            let labelX:CGFloat = labelW * (CGFloat(index))
            label.frame = CGRect(x:labelX,y:labelY,width:labelW,height:labelH)
            
            //4.将label添加到scrollView中
            scrollerView.addSubview(label)
            titlesLabels.append(label)
            
            //5. 添加手势点击
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titlesLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
            
            
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
        firstLabel.textColor = UIColor(r:SelectColor.0,g:SelectColor.1,b:SelectColor.2)
        scrollerView.addSubview(scrollerLine)
        scrollerLine.frame = CGRect(x:firstLabel.frame.origin.x,y:frame.height-HscrollLineH,width:firstLabel.frame.width,height:HscrollLineH)
        
    }
    
    
}

//mark -- 监听label的点击
extension SCHPageTitleView {
    //时间点击 要用@objc
    @objc private func titlesLabelClick(tapGes:UITapGestureRecognizer){
        //1.获取当前点击的label的下标志
        let currentLabel = tapGes.view as? UILabel
        
        //2.获取之前的label
        let oldLabel = titlesLabels[currentIndex]
        
        //3.切换颜色值
        currentLabel?.textColor = UIColor(r:SelectColor.0,g:SelectColor.1,b:SelectColor.2)
        oldLabel.textColor = UIColor(r:NormalColor.0,g:NormalColor.1,b:NormalColor.2)
        
        //4.保存最新的label的下标志
        currentIndex = (currentLabel?.tag)!
        
        //5.滚动条位置发生变化
        let scrollLinx = CGFloat(currentIndex) * scrollerLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollerLine.frame.origin.x = scrollLinx
        }
        
        
        //6.通知代理做事情
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}
//mark -- 对外暴露的方法
extension SCHPageTitleView {
    func setTitleWithProgress(progress:CGFloat,sourceIndex:Int,targetIndex:Int){
        //1.取出sourceIndex 和 targetIndex 对应的label
        let sourceLabel = titlesLabels[sourceIndex]
        let targetLabel = titlesLabels[targetIndex]
        
        //2.处理滚动条的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollerLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3.label发生渐变(复杂)
          //3.1 取出变化的范围
        let coloDelta = (SelectColor.0 - NormalColor.0,SelectColor.1 - NormalColor.1,SelectColor.2 - NormalColor.2)
        sourceLabel.textColor = UIColor(r: SelectColor.0 - coloDelta.0 * progress, g: SelectColor.1 - coloDelta.1 * progress, b: SelectColor.2 - coloDelta.2 * progress)
        targetLabel.textColor = UIColor(r: NormalColor.0 + coloDelta.0 * progress, g: NormalColor.1 + coloDelta.1 * progress, b: NormalColor.2 + coloDelta.2 * progress)
        
        
        //4.记录最新的index
        currentIndex = targetIndex
    }
}
