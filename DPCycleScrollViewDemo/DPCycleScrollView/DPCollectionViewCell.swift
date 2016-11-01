//
//  DPCollectionViewCell.swift
//  moneyBar
//
//  Created by 丁雨平 on 16/8/16.
//  Copyright © 2016年 DP_star. All rights reserved.
//

import UIKit

class DPCollectionViewCell: UICollectionViewCell {
    
    var imageView : UIImageView!
    var titleLabel : UILabel!
    
    //MARK: set方法
    var titleLabelTextColor: UIColor! {
        didSet {
            titleLabel.textColor = titleLabelTextColor
        }
    }
    var titleLabelTextFont: UIFont! {
        didSet {
            titleLabel.font = titleLabelTextFont
        }
    }
    var titleLabelBackgroundColor: UIColor! {
        didSet {
            titleLabel.backgroundColor = titleLabelBackgroundColor
        }
    }
    var titleLabelHeight: CGFloat! {
        didSet {
            titleLabel.frame = CGRect(x: 0, y: self.height-titleLabelHeight, width: self.height, height: titleLabelHeight)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        contentView.addSubview(imageView)
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: self.height-40.0, width: self.width, height: 40.0))
        contentView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 15.0)
        titleLabel.backgroundColor = OverallTool.getRGBColor(0, g: 0, b: 0, a: 0.3)
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = self.bounds
    }

    func setTitleLabelText(_ str : String) {
        titleLabel.text = "    " + str
    }
    
}
