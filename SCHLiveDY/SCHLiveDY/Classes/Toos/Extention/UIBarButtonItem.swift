//
//  UIBarButtonItem.swift
//  SCHLiveDY
//
//  Created by Mike on 2018/2/1.
//  Copyright © 2018年 Mike. All rights reserved.
//

import UIKit
extension UIBarButtonItem {
    
    /*
    class func createItem(imageName:String,highImageName:String,size:CGSize) -> UIBarButtonItem{
        
        let size = CGSize(width:40,height:40)
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: UIControlState.normal)
        btn.setImage(UIImage(named:highImageName), for: UIControlState.highlighted)
        btn.frame = CGRect.init(origin:CGPoint.init(x: 0, y: 0), size: size)
        return UIBarButtonItem.init(customView: btn)
    }
 */
    //swift跟推荐使用构造函数
    //便利构造函数：1.必须以convenience开头 2.在构造函数中必须明确调用一个设计的构造函数self
    // = ：代表可有可无  相传就传不想传就不传
    convenience init(imageName:String,highImageName:String = "",size:CGSize = CGSize.zero){
        //1.创建UIButton
        let btn = UIButton()
        
        //2.设置图片
        btn.setImage(UIImage(named:imageName), for: UIControlState.normal)
        
        //设置高亮图片
        if highImageName != ""{
            btn.setImage(UIImage(named:highImageName), for: UIControlState.highlighted)
        }
        //3.设置尺寸
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect.init(origin:CGPoint.init(x: 0, y: 0), size: size)
        }
        
        //4.创建UIBarButtonItem
        self.init(customView: btn)
    }
}
