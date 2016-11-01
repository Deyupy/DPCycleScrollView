//
//  DPCycleScrollView.swift
//  moneyBar
//
//  Created by 丁雨平 on 16/8/16.
//  Copyright © 2016年 DP_star. All rights reserved.
//

import UIKit

enum DPCycleScrollViewPageControlAligment {
    case right
    case center
}

protocol DPCycleScrollViewDelegate {
    
    /** 点击图片回调 */
    func didSelectCycleScrollViewItem(_ cycleScrollView: DPCycleScrollView, index: NSInteger)
}

private let ID = "cycleCell"

class DPCycleScrollView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {

    //MARK:- 数据源
    /** 网络图片 url string 数组 */
    var imageURLStringsGroup : NSArray? {
        didSet {
            imagePathsGroup = NSMutableArray(array: imageURLStringsGroup!)
            if (imageURLStringsGroup?.count)! > 1 {
                imagePathsGroup?.insert((imageURLStringsGroup?.lastObject)!, at: 0)
                imagePathsGroup?.add(imageURLStringsGroup!.firstObject!)
                pageControlNums = (imagePathsGroup?.count)!-2
                pageControl?.numberOfPages = pageControlNums!
            }else {
                pageControlNums = (imagePathsGroup?.count)!
                pageControl?.numberOfPages = pageControlNums!
                mainView.isScrollEnabled = false
            }
            if pageControlNums! <= 1 {
                hidesForSinglePage = true
            }
        }
    }
    
    /** 本地图片数组 */
    var localizationImageNamesGroup : NSArray? {
        didSet {
            imagePathsGroup = NSMutableArray(array: localizationImageNamesGroup!)
            if (localizationImageNamesGroup?.count)! > 1 {
                imagePathsGroup?.insert((localizationImageNamesGroup?.lastObject)!, at: 0)
                imagePathsGroup?.add(localizationImageNamesGroup!.firstObject!)
                pageControlNums = (imagePathsGroup?.count)!-2
                pageControl?.numberOfPages = pageControlNums!
            }else {
                pageControlNums = (imagePathsGroup?.count)!
                pageControl?.numberOfPages = pageControlNums!
                mainView.isScrollEnabled = false
            }
            if pageControlNums! <= 1 {
                hidesForSinglePage = true
            }
        }
    }

    //MARK: - 滚动控制
    /** 自动滚动间隔时间,默认3s */
    var autoScrollTimeInterval : Double? {
        didSet {
            if timer != nil {
                timer.invalidate()
                timer = nil
            }
            setupTimer()
        }
    }

    /** 是否自动滚动,默认Yes */
    var autoScroll : Bool? {
        didSet {
            if autoScroll == true {
                if timer == nil {
                    setupTimer()
                }else {
                    timer.invalidate()
                    timer = nil
                    setupTimer()
                }
            }else {
                if timer != nil {
                    timer.invalidate()
                    timer = nil
                }
            }
        }
    }
    
    /** 图片滚动方向，默认为水平滚动 */
    var scrollDirection : UICollectionViewScrollDirection? {
        didSet {
            flowLayout.scrollDirection = scrollDirection!
        }
    }
    
    var delegate : DPCycleScrollViewDelegate?

    //MARK: - 自定义样式
    /** 每张图片对应要显示的文字数组 */
    var titlesGroup : NSMutableArray? {
        didSet {
            if (titlesGroup?.count)! > 1 {
                titlesGroup?.insert((titlesGroup?.lastObject)!, at: 0)
                titlesGroup?.add((titlesGroup?.firstObject)!)
            }
        }
    }
    
    /** 设置文本样式 */
    var titleLabelTextColor: UIColor?
    var titleLabelTextFont: UIFont?
    var titleLabelBackgroundColor: UIColor?
    var titleLabelHeight: CGFloat?
    
    /** 轮播图片的ContentMode，默认为 UIViewContentModeScaleToFill */
    var bannerImageViewContentMode : UIViewContentMode?
    
    /** 占位图，用于网络未加载到图片时 */
    var placeholderImage : UIImage?
    
    /** 是否显示分页控制 */
    var showPageControl : Bool? {
        didSet {
            if showPageControl == true {
                if pageControl == nil {
                    setupPageControl()
                }
                pageControl?.isHidden = false
            }else {
                pageControl?.isHidden = true
            }
        }
    }
    
    /** 是否在只有一张图时隐藏pagecontrol，默认为YES */
    var hidesForSinglePage : Bool? {
        didSet {
            pageControl?.isHidden = hidesForSinglePage!
        }
    }
    
    /** 分页控件位置 */
    var pageControlAliment : DPCycleScrollViewPageControlAligment? {
        didSet {
            if pageControlAliment == DPCycleScrollViewPageControlAligment.right {
                let pageControl_width = (CGFloat)(pageControlNums!)*15.0 + 10.0
                pageControl?.frame = CGRect(x: mainView.width - pageControl_width, y: mainView.bottom - 40.0, width: pageControl_width, height: 40.0)
   
            }
        }
    }

    /** 当前分页控件小圆标颜色 */
    var currentPageDotColor : UIColor? {
        didSet {
            pageControl?.currentPageIndicatorTintColor = currentPageDotColor
        }
    }
    
    /** 其他分页控件小圆标颜色 */
    var pageDotColor : UIColor? {
        didSet {
            pageControl?.pageIndicatorTintColor = pageDotColor
        }
    }

    //MARK: - 私有属性，不提供给外部
    /** 显示图片的collectionView */
    fileprivate var mainView : UICollectionView!
    fileprivate var flowLayout : UICollectionViewFlowLayout!
    
    /** cell数据源 */
    fileprivate var imagePathsGroup : NSMutableArray?
    
    /** 定时器 */
    fileprivate var timer : Timer!
    
    /** 分页控件页数 */
    fileprivate var pageControlNums : NSInteger?
    
    /** 分页控制器 */
    var pageControl : UIPageControl?
    
    //MARK: - 创建cycleScrollView
    /**
     网络图片轮播初始化方式
     
     - parameter frame:            frame
     - parameter placeholderImage: 占位图
     - parameter delegate:         delegate
     
     - returns: 轮播图对象
     */
    class func initCycleScrollView(_ frame: CGRect, placeholderImage: UIImage, delegate: DPCycleScrollViewDelegate) -> DPCycleScrollView {
        let cycleScrollView = DPCycleScrollView(frame: frame)
        cycleScrollView.delegate = delegate
        cycleScrollView.placeholderImage = placeholderImage
        
        return cycleScrollView
    }
    
    /**
     本地图片轮播初始化方式
     
     - parameter frame:           frame
     - parameter imageNamesGroup: 本地图片数组
     
     - returns: 轮播图对象
     */
    class func initCycleScrollView(_ frame: CGRect, imageNamesGroup: NSArray, delegate: DPCycleScrollViewDelegate) -> DPCycleScrollView {
        let cycleScrollView = DPCycleScrollView(frame: frame)
        cycleScrollView.localizationImageNamesGroup = imageNamesGroup
        cycleScrollView.delegate = delegate
        
        return cycleScrollView
    }
    
    //MARK:- 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createView()
        initData()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //  初始化数据
    func initData() {
        autoScrollTimeInterval = 3.0
        autoScroll = true
        bannerImageViewContentMode = UIViewContentMode.scaleToFill
    }
    //  创建视图
    func createView() {
        setupMainView()
    }
    
    //  设置显示图片的collectionview
    fileprivate func setupMainView() {
        
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.itemSize = bounds.size
        
        mainView = UICollectionView(frame: bounds, collectionViewLayout: flowLayout)
        mainView.backgroundColor = UIColor.clear
        mainView.isPagingEnabled = true
        mainView.showsVerticalScrollIndicator = false
        mainView.showsHorizontalScrollIndicator = false
        mainView.register(DPCollectionViewCell.self, forCellWithReuseIdentifier: ID)
        mainView.delegate = self
        mainView.dataSource = self
        addSubview(mainView)
    }
    
    //  分页指示器
    fileprivate func setupPageControl() {
        pageControl = UIPageControl.init(frame: CGRect(x: 0, y: mainView.bottom-40.0, width: width, height: 40.0))
        addSubview(pageControl!)
        pageControl?.isUserInteractionEnabled = false
        pageControl?.numberOfPages = pageControlNums!
        pageControl?.currentPage = 0
        pageControl?.currentPageIndicatorTintColor = UIColor.red
        pageControl?.pageIndicatorTintColor = UIColor.lightGray
    }
    
    //  定时器，自动轮播
    func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: autoScrollTimeInterval!, target: self, selector: #selector(automaticScroll), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
    }

    //MARK: - 定时器事件
    func automaticScroll() {
        let currentIndex = getCurrentIndex()
        pageControl?.currentPage = currentIndex % pageControlNums!
        print("---\(currentIndex % pageControlNums!)")
        
        let targetIndex = currentIndex + 2
        if targetIndex >= imagePathsGroup!.count {
            mainView.scrollToItem(at: IndexPath(item: 0, section: 0), at: UICollectionViewScrollPosition(), animated: false)
            mainView.scrollToItem(at: IndexPath(item: 1, section: 0), at: UICollectionViewScrollPosition(), animated: true)
            return
        }
        mainView.scrollToItem(at: IndexPath(item: currentIndex+1, section: 0), at: UICollectionViewScrollPosition(), animated: true)
    }
    
    func getCurrentIndex() -> Int {
        if mainView.width == 0 || mainView.height == 0 {
            return 0
        }
        
        var index = 0
        if flowLayout.scrollDirection == UICollectionViewScrollDirection.horizontal {
            index = (Int)(mainView.contentOffset.x + flowLayout.itemSize.width * 0.5) / (Int)(flowLayout.itemSize.width)
        }else {
            index = (Int)(mainView.contentOffset.y + flowLayout.itemSize.height * 0.5) / (Int)(flowLayout.itemSize.height)
        }
        return index
    }
    
    //MARK:- UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagePathsGroup!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath) as! DPCollectionViewCell
        
        cell.imageView.contentMode = bannerImageViewContentMode!
        let str = imagePathsGroup![(indexPath as NSIndexPath).row] as! String
        if str.hasPrefix("http") {
            cell.imageView.sd_setImage(with: URL(string:imagePathsGroup![(indexPath as NSIndexPath).row] as! String), placeholderImage: UIImage(named: "placeHolder")!)
        }else {
        
            cell.imageView.image = UIImage(named: imagePathsGroup![(indexPath as NSIndexPath).row] as! String)
        }
        
        if titlesGroup != nil {
            cell.setTitleLabelText((titlesGroup![indexPath.row] as? String)!)
        }
        if titleLabelTextColor != nil {
            cell.titleLabelTextColor = titleLabelTextColor
        }
        if titleLabelTextFont != nil {
            cell.titleLabelTextFont = titleLabelTextFont
        }
        if titleLabelBackgroundColor != nil {
            cell.titleLabelBackgroundColor = titleLabelBackgroundColor
        }
        if titleLabelHeight != nil {
            cell.titleLabelHeight = titleLabelHeight
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if delegate != nil {
            delegate?.didSelectCycleScrollViewItem(self, index: (indexPath as NSIndexPath).row-1)
        }
//        print("--- select \(indexPath.row)")
    }
    
    //MARK: - UIScrollViewDelegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if autoScroll == true {
            if timer == nil {
                setupTimer()
            }
        }
        let currentIndex = getCurrentIndex()
        var pageIndex = currentIndex % pageControlNums! - 1
        if pageIndex < 0 {
            pageIndex = pageControlNums! - 1
        }
        pageControl?.currentPage = pageIndex
        
        let targetIndex = (imagePathsGroup?.count)!-1
        if currentIndex == targetIndex {
            mainView.scrollToItem(at: IndexPath(item: 1, section: 0), at: UICollectionViewScrollPosition(), animated: false)
        }
        if currentIndex == 0 {
            mainView.scrollToItem(at: IndexPath(item: targetIndex-1, section: 0), at: UICollectionViewScrollPosition(), animated: false)
        }
        print("---\(pageIndex)")
    }
    
    //MARK: - 生命周期方法
    override func layoutSubviews() {
        super.layoutSubviews()
        if (mainView.contentOffset.x == 0 && (imagePathsGroup?.count)! > 0) {
            mainView.scrollToItem(at: IndexPath(item: 1, section: 0), at: UICollectionViewScrollPosition(), animated: false)
        }
    }
    
}
