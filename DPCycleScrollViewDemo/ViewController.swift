//
//  ViewController.swift
//  DPCycleScrollViewDemo
//
//  Created by 丁雨平 on 2016/10/18.
//  Copyright © 2016年 DP_star. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DPCycleScrollViewDelegate {

    var localScrollView: DPCycleScrollView?
    var netScrollView: DPCycleScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        createView()
    }

    //MARK: -  懒加载
    lazy var localImages : NSArray = {
        let arr = ["1.jpg","2.jpg","3.jpg","4.jpg"]
        return arr as NSArray
    }()
    lazy var netImages : NSArray = {
        let arr = ["http://image.vlook.cn/static/user/mKFe/180/kWBLLGY.jpg","http://img4.duitang.com/uploads/item/201601/03/20160103205435_nuNAL.thumb.224_0.jpeg","http://imgsrc.baidu.com/forum/w=580/sign=cc15699437d3d539c13d0fcb0a86e927/e54019899e510fb30adb3efdd833c895d0430c22.jpg","http://www.baduqq.com/uploads/allimg/130120/10393VA3-3.jpg"]
        return arr as NSArray
    }()
    lazy var titleTexts : NSMutableArray = {
        let arr = NSMutableArray.init(array: ["横看成岭侧成峰", "远近高低各不同", "不识庐山真面目", "只缘身在此山中"])
        return arr as NSMutableArray
    }()

    //MARK: - 创建
    private func createView() {
        
        addLocalScrollView()
        addNetScrollView()
        
        print("----"+NSHomeDirectory())
    }
    
    /// 添加本地图片
    private func addLocalScrollView() {
        localScrollView = DPCycleScrollView.initCycleScrollView(CGRect(x: 0, y: 0, width: OverallTool.ScreenWidth, height: 200), imageNamesGroup: localImages, delegate: self)
        localScrollView?.showPageControl = true
        localScrollView?.pageControlAliment = DPCycleScrollViewPageControlAligment.right
        localScrollView?.titlesGroup = ["是谁在菩提树下细数轮回了一季又一季的满帘落花", "一首相思", "一阙宋词", "涟漪了前世今生的眷恋"]
        localScrollView?.pageDotColor = UIColor.yellow
        localScrollView?.titleLabelBackgroundColor = OverallTool.getRGBColor(123, g: 255, b: 45, a: 0.3)
        view.addSubview(localScrollView!)
    }
    
    /// 添加网络图片
    private func addNetScrollView() {
        netScrollView = DPCycleScrollView.initCycleScrollView(CGRect(x: 0, y: 250, width: OverallTool.ScreenWidth, height: 200), placeholderImage: UIImage(named: "placeHolder")!, delegate: self)
        netScrollView?.imageURLStringsGroup = netImages
        netScrollView?.showPageControl = true
        netScrollView?.pageControlAliment = DPCycleScrollViewPageControlAligment.center
        netScrollView?.autoScrollTimeInterval = 2.0
        netScrollView?.titlesGroup = titleTexts
        netScrollView?.titleLabelTextColor = UIColor.green
        view.addSubview(netScrollView!)
    }
    
    //MARK: - 代理
    func didSelectCycleScrollViewItem(_ cycleScrollView: DPCycleScrollView, index: NSInteger) {
        print("---select -- \(index)")
        UIApplication.shared.open(URL(string: "http://www.baidu.com")!, options: [:]) { (false) in
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

