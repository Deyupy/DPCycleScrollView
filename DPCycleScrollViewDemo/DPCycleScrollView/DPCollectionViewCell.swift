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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        contentView.addSubview(imageView)
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = self.bounds
    }

}
