//
//  UIViewController+Category.swift
//  ZYImageChince-Swift
//
//  Created by ybon on 2016/12/3.
//  Copyright © 2016年 ybon. All rights reserved.
//

import Foundation
import UIKit
extension UIView{

    func zyViewController() -> UIViewController? {
        var next = self.next;
       
        while next != nil {
            if next is UIViewController {
                return next as? UIViewController;
            }
            next = next?.next;
        }
        
        
        return nil;
    }
    
}
extension UIViewController{
    func showAlert(title:String,message:String){
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert);
        let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.cancel, handler: nil);
        alert.addAction(action);
        self.present(alert, animated: true, completion: nil);
    }

}
