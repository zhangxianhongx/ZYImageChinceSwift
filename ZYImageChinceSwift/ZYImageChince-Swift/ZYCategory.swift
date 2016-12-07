//
//  ZYCategory.swift
//  ZYImageChince-Swift
//
//  Created by ybon on 2016/12/5.
//  Copyright © 2016年 ybon. All rights reserved.
//

import Foundation
import UIKit
extension UIView{
    //找到UIView及其子类的跟视图控制器
    func zyviewController() -> UIViewController? {
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
extension String{
   //验证是否是邮箱
    func isEmailWihtemailString(Str:String)->Bool{
        
        let regix = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", regix);
        let isValid = predicate.evaluate(with: Str);
        
        return isValid;
    }
    //验证手机号
    func validateMobile(Str:String)-> Bool{
        if Str == "" {
            return false;
        }
       let MU = "^((14[5,7])|(13[0-9])|(17[0-9])|(15[^4,\\D])|(18[0,1-9]))\\d{8}$";
        let regextestMU = NSPredicate.init(format: "SELF MATCHES %@", MU);
        if regextestMU.evaluate(with: Str) == true {
            return true;
        }else{
            return false;
        }
    }
    //验证身份证
    func validateIdentityCard(Str:String)->Bool{
        if Str == ""{
            return false;
        }
        let regex = "^(\\d{14}|\\d{17})(\\d|[xX])$";
        let identityCardPredicate = NSPredicate.init(format: "SELF MATCHES %@", regex);
        return identityCardPredicate.evaluate(with: Str);
    }
    //判断数字是否为纯数字
    func isPureNumandCharacters(Str:String)->Bool{
        if Str == "" {
            return false;
        }
       let resuStr = Str.trimmingCharacters(in: CharacterSet.decimalDigits);
        if resuStr != "" {
            return false;
        }
        return true;
    }
    
    
    
}
