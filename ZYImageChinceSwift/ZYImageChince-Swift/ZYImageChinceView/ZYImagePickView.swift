//
//  ZYImagePickView.swift
//  ZYImageChince-Swift
//
//  Created by ybon on 2016/12/7.
//  Copyright © 2016年 ybon. All rights reserved.
//

import UIKit

class ZYImagePickView: UIView ,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    var _imageArray:Array<UIImage>?;
    var imageArray:Array<UIImage>{
        set {
            _imageArray = newValue;
            creatSubViews();
        }
        get {
            return _imageArray!;
        }
    }
    private var maxCount:Int?;
    init(frame: CGRect, maxcount:Int) {
        super.init(frame: frame);
        _imageArray = Array.init();
        maxCount = maxcount;
        creatSubViews();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  

    //creatSubViws
    func creatSubViews(){
        
        for sview in self.subviews {
            sview.removeFromSuperview();
            
        }
        
        let spece = 10.0 as CGFloat;
        let width = (self.bounds.size.width - CGFloat(spece) * CGFloat(4))/3;
        var i = 0;
        for img in _imageArray! {
            let imageV = UIImageView.init(frame: CGRect.init(x: spece + CGFloat(i%3) * (width + spece), y: spece + CGFloat(i/3) * (width + spece), width: width, height: width));
            imageV.image = img;
            imageV.layer.cornerRadius = 4;
            imageV.layer.masksToBounds = true;
            imageV.contentMode = .scaleAspectFill;
            imageV.isUserInteractionEnabled = true;
            self.addSubview(imageV);
            let btn = UIButton.init(type: UIButtonType.system);
            btn.frame = CGRect.init(x: imageV.bounds.size.width-20, y: 0, width: 20, height: 20);
            imageV.addSubview(btn);
            btn.tag = 100 + i;
            btn.addTarget(self, action: #selector(deleBtnAction), for: UIControlEvents.touchUpInside);
            btn.setBackgroundImage(UIImage.init(named: "button_icon_close"), for: UIControlState.normal);
            i = i + 1;
        }
        if (_imageArray?.count)! < maxCount! {
            
            let btn = UIButton.init(type: UIButtonType.system);
            btn.frame = CGRect.init(x: spece + CGFloat(i%3) * (width + spece), y: spece + CGFloat(i/3) * (width + spece), width: width, height: width);
            self.addSubview(btn);
            
            btn.addTarget(self, action: #selector(addBtnAction), for: UIControlEvents.touchUpInside);
            btn.setBackgroundImage(UIImage.init(named: "btn_add_photo_s"), for: UIControlState.normal);

        }
        
    }
    //相机拍摄图片
    func selectedImageFormCarma(){
        let pick = UIImagePickerController.init();
        pick.sourceType = UIImagePickerControllerSourceType.camera;
        pick.delegate = self;
        self.zyViewController()?.present(pick, animated: true, completion: nil);
    }
    //图库选择图片
    func selectedImageFormLibray(){
        let viewC = ZYImageViewController.init();
        viewC.maxCount = maxCount! - (_imageArray?.count)!;
        self.zyViewController()?.present(UINavigationController.init(rootViewController: viewC), animated: true, completion: nil);
        
        viewC.selectImageFaction = { (imgArray) -> Void in
            self._imageArray = imgArray;
            self.creatSubViews();
            
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil);
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if picker.sourceType == UIImagePickerControllerSourceType.camera {
            let image = info[UIImagePickerControllerOriginalImage];
            _imageArray?.append(image as! UIImage);
            creatSubViews();
            picker.dismiss(animated: true, completion: nil);
        }
        
    }
    //addBtnAction
    func addBtnAction(btn:UIButton){
        
        let alert = UIAlertController.init(title: "选择图片来源", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet);
        let catma = UIAlertAction.init(title: "相机", style: UIAlertActionStyle.default) { (UIAlertActionn) in
            self.selectedImageFormCarma();
        }
        let libray = UIAlertAction.init(title: "相册", style: UIAlertActionStyle.default) { (UIAlertAction) in
            self.selectedImageFormLibray();
        }
        let cancel = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel, handler: nil);
        alert.addAction(catma);
        alert.addAction(libray);
        alert.addAction(cancel);
        self.zyViewController()?.present(alert, animated: true, completion: nil);
    }
    //deleBtnAction
    func deleBtnAction(btn:UIButton){
        _imageArray?.remove(at: btn.tag-100);
        creatSubViews();
    }
    
}
