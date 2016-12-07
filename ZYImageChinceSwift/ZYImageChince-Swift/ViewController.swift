//
//  ViewController.swift
//  ZYImageChince-Swift
//
//  Created by ybon on 2016/12/3.
//  Copyright © 2016年 ybon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        let pickV = ZYImagePickView.init(frame: CGRect.init(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: 300), maxcount: 9);
        self.view.addSubview(pickV);
        
    }


}

