//
//  UIView+DPExtension.swift
//  moneyBar
//
//  Created by 丁雨平 on 16/8/16.
//  Copyright © 2016年 DP_star. All rights reserved.
//

import UIKit

extension UIView {

    public var left: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var tempFrame = self.frame
            tempFrame.origin.x = newValue
            self.frame = tempFrame
        }
    }
    
    public var top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var tempFrame = self.frame
            tempFrame.origin.y = newValue
            self.frame = tempFrame
        }
    }
    
    public var right: CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        set {
            var tempFrame = self.frame
            tempFrame.origin.x = newValue - tempFrame.size.width
            self.frame = tempFrame
        }
    }
    
    public var bottom: CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
        set {
            var tempFrame = self.frame
            tempFrame.origin.y = newValue - tempFrame.size.height
            self.frame = tempFrame
        }
    }
    
    public var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var tempFrame = self.frame
            tempFrame.size.width = newValue
            self.frame = tempFrame
        }
    }
    
    public var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var tempFrame = self.frame
            tempFrame.size.height = newValue
            self.frame = tempFrame
        }
    }
    
    public var centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    public var centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
    
    public var origin: CGPoint{
        get{
            return self.frame.origin
        }
        set{
            var tempFrame = self.frame
            tempFrame.origin = newValue
            self.frame = tempFrame
        }
    }
    
    public var size: CGSize{
        get{
            return self.frame.size
        }
        set{
            var tempFrame = self.frame
            tempFrame.size = newValue
            self.frame = tempFrame
        }
    }
    
}





