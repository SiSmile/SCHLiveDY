//
//  SCHPageContentView.swift
//  SCHLiveDY
//
//  Created by Mike on 2018/2/2.
//  Copyright © 2018年 Mike. All rights reserved.
//

import UIKit

protocol SCHPageContentViewDelegate:class {
    func pagecontentView(contentView:SCHPageContentView,progress:CGFloat,sourceIndex:Int,targetIndex:Int)
}

private let ContentCellId = "ContentCollectionCell"
class SCHPageContentView: UIView {

    //Mark -- 定义属性
    private var childNumber:Int
    private weak var parentViewController:UIViewController? = UIViewController()
    private var childVCs:[UIViewController] = []
    private var startOffsetX:CGFloat = 0
    weak var delegate:SCHPageContentViewDelegate?
    private var isForbidScorllDelegate:Bool = false
    
    //Mark -- 懒加载collectionView
    private lazy var collectionView:UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = bounds.size
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: (self?.bounds)!, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellId)
        return collectionView
    }()
    
    //Mark -- 构造函数
    init(frame:CGRect,childNumber:Int,parentViewController:UIViewController?) {
        self.childNumber = childNumber
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        // 设置UI
        setUIContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//MARK--设置UI
extension SCHPageContentView {
    
    private func setUIContentView() {
        //1.添加到父控制器上
        for _ in 0..<self.childNumber {
            let vc:UIViewController = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVCs.append(vc)
            
            parentViewController?.addChildViewController(vc)
        }
        
        //2.添加到collectionCell
        addSubview(collectionView)
        
    }
}

//MARK -- 遵守UICollectionViewDataSource
extension SCHPageContentView :UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellId, for: indexPath)
        
        //2.加载子控制器之前先清一下cell的contentView
        for view in cell.contentView.subviews
        {
            view.removeFromSuperview()
        }
        
        //3.加载子控制器
        let  childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
    
}
//MARK -- 遵守UICollectionViewDelegate
extension SCHPageContentView:UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //开始拖拽 -- 判断左滑还是右滑
        startOffsetX = scrollView.contentOffset.x
        
        isForbidScorllDelegate = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //0.判断是否是点击事件
        if isForbidScorllDelegate {
            return
        }
        
        //1.获取需要的数据
         /*
             获取滑动进度、原来的index（改变label的颜色）、目标的index
         */
        var progress:CGFloat = 0
        var sourceIndex:Int = 0
        var targetIndex:Int = 0
        
        //2.判断左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX {
            //左滑
            //1.计算progress
            //floor为取整函数
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            //2.计算sourceIndex
            sourceIndex = Int (currentOffsetX / scrollViewW)
            
            //3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCs.count {
               targetIndex = childVCs.count - 1
            }
            
            //4. 滑动完成
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        }else{
            //右滑
            //1.计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            //2.计算targetIndex
            targetIndex = Int (currentOffsetX / scrollViewW)
            
            //3.计算sourceIndex
            sourceIndex = targetIndex+1
            if sourceIndex >= childVCs.count
            {
                sourceIndex = childVCs.count - 1
            }
            
//            //4. 滑动完成
//            if currentOffsetX - startOffsetX == scrollViewW {
//                progress = 1
//                sourceIndex = targetIndex
//            }
        }
        
        //3. 将 获取滑动进度、原来的index（改变label的颜色）、目标的index 传给titleView
        delegate?.pagecontentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
        print("progress:\(progress) sourceIndex:\(sourceIndex) targetIndex:\(targetIndex)")
    }
}


//MARK -- 对外暴露的方法
extension SCHPageContentView {
    func setCurrentIndex(currentIndex:Int){
        //1.在用户点击标题的时候禁止执行代理方法
        isForbidScorllDelegate = true
        
        //2.滚动到正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: true)
    }
}
