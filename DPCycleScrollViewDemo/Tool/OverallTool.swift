//
//  OverallTool.swift
//  moneyBar
//
//  Created by 丁雨平 on 16/8/15.
//  Copyright © 2016年 DP_star. All rights reserved.
//

import UIKit

class OverallTool: NSObject {
    /**
     *  用来定义全局的宏
     */
    
    //MARK:- 自定义RGB颜色
    class func getRGBColor(_ r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    //MARK:- 获取屏幕宽和高
    static let ScreenWidth : CGFloat = {
        return UIScreen.main.bounds.width
    }()
    static let ScreenHeight : CGFloat = {
        return UIScreen.main.bounds.height
    }()
    
    //MARK: - 设备系统识别
    class func iOS9() -> Bool {
        let version = UIDevice.current.systemVersion
        return ((version as NSString).doubleValue >= 9.0 ? true : false)
    }
    class func iOS8() -> Bool {
        let version = UIDevice.current.systemVersion
        return ((version as NSString).doubleValue >= 8.0 ? true : false)
    }
    class func iOS7() -> Bool {
        let version = UIDevice.current.systemVersion
        return ((version as NSString).doubleValue >= 7.0 ? true : false)
    }
    
    
}
