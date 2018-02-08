//
//  SCHRecommendViewController.swift
//  SCHLiveDY
//
//  Created by Mike on 2018/2/8.
//  Copyright © 2018年 Mike. All rights reserved.
//

import UIKit
private let ItemsNumber:Int = 2
private let ItemsMargin:CGFloat = 10
private let ItemsWidth:CGFloat = (SCHKscreenW - CGFloat(ItemsNumber+1)*ItemsMargin)/CGFloat(ItemsNumber)
private let ItemsHeight:CGFloat = ItemsWidth*3/4

private let ItemsHeaderHeight:CGFloat = 50

class SCHRecommendViewController: UIViewController {

    private lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: ItemsWidth, height: ItemsHeight)
        layout.scrollDirection  = UICollectionViewScrollDirection.vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = ItemsMargin
        layout.headerReferenceSize = CGSize(width: SCHKscreenW, height: ItemsHeaderHeight)
        layout.sectionInset = UIEdgeInsetsMake(0, ItemsMargin, 0, ItemsMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.yellow
        collectionView.delegate = self
        collectionView.dataSource = self
        //随着父控件缩小放大
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        //注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
        //注册header
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerID")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setUI();
        
    }
    
}

//mark -- 设置UI
extension SCHRecommendViewController {
    private func setUI(){
        //1.加载CollectionView
        view.addSubview(collectionView)
    }
}
//mark -- 遵守协议
extension SCHRecommendViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }else{
            return 4;
        }
    
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath)
        cell.backgroundColor = UIColor.blue
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath)
        headerView.backgroundColor = UIColor.red
        return headerView
        
    }
}
