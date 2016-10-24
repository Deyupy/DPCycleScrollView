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

    //MARK: - 创建
    private func createView() {
        
        addLocalScrollView()
        addNetScrollView()
        
        print("----"+NSHomeDirectory())
        
        let image = UIImageView(frame: CGRect(x: 0, y: 400, width: 200, height: 100))
        image.sd_setImage(with: URL(string: "http://image.mifengkong.cn/qianba/organization_id_36/579f00415e54f658392338.png"), placeholderImage: UIImage(named: "placeHolder")!)
        view.addSubview(image)
    }
    
    /// 添加本地图片
    private func addLocalScrollView() {
        localScrollView = DPCycleScrollView.initCycleScrollView(CGRect(x: 0, y: 0, width: OverallTool.ScreenWidth, height: 200), imageNamesGroup: localImages)
        localScrollView?.delegate = self
        localScrollView?.showPageControl = true
        localScrollView?.pageControlAliment = DPCycleScrollViewPageControlAligment.center
        view.addSubview(localScrollView!)
    }
    
    /// 添加网络图片
    private func addNetScrollView() {
        netScrollView = DPCycleScrollView.initCycleScrollView(CGRect(x: 0, y: (localScrollView?.bottom)!, width: OverallTool.ScreenWidth, height: 200), placeholderImage: UIImage(named: "placeHolder")!, delegate: self)
        netScrollView?.imageURLStringsGroup = netImages
        netScrollView?.showPageControl = true
        netScrollView?.pageControlAliment = DPCycleScrollViewPageControlAligment.center
        netScrollView?.autoScrollTimeInterval = 1.0
        view.addSubview(netScrollView!)
    }
    
    //MARK: - 代理
    func didSelectCycleScrollViewItem(_ cycleScrollView: DPCycleScrollView, index: NSInteger) {
        print("---select -- \(index)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

