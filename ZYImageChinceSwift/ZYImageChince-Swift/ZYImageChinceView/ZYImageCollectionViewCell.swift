//
//  ZYImageCollectionViewCell.swift
//  ZYImageChince-Swift
//
//  Created by ybon on 2016/12/7.
//  Copyright © 2016年 ybon. All rights reserved.
//

import UIKit
import Photos
class ZYImageCollectionViewCell: UICollectionViewCell {
    
    var imageV:UIImageView?;
    var selectedImageV:UIImageView?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.layer.masksToBounds = true;
        creatSubViews();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //creat subViews
    func creatSubViews(){
        imageV = UIImageView.init(frame: self.bounds);
        self.addSubview(imageV!);
        selectedImageV = UIImageView.init(frame: CGRect.init(x: self.bounds.size.width-18, y: 0, width: 18, height: 18));
        imageV?.contentMode = .scaleAspectFill;
        imageV?.layer.cornerRadius = 5;
        imageV?.layer.masksToBounds = true;
        selectedImageV?.tag = 2001;
        selectedImageV?.isHidden = true;
        selectedImageV?.image = UIImage.init(named: "checkmark");
        self.addSubview(selectedImageV!);
        imageV?.isUserInteractionEnabled = true;
        selectedImageV?.isUserInteractionEnabled = true;
    }
    override func layoutSubviews() {
        super.layoutSubviews();
        imageV?.frame = self.bounds;
        
    }
    
    
}
