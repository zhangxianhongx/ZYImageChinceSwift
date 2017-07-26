//
//  ZYImageViewController.swift
//  ZYImageChince-Swift
//
//  Created by ybon on 2016/12/7.
//  Copyright © 2016年 ybon. All rights reserved.
//

import UIKit
import Photos
class ZYImageViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{
    var maxCount = 0;
    var selectImageFaction:((_ imageArr:Array<UIImage>)->Void)?;
   private var dataArray:Array<UIImage>?;
   private var selectedArray:Array<UIImage>?;
   private var _collectionView:UICollectionView?;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;
        self.view.backgroundColor = UIColor.white;
        if maxCount <= 0{
            maxCount = 3;
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelBarItemAction));
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "确定", style: UIBarButtonItemStyle.plain, target: self, action: #selector(sureBarItemAction));
        let layout = UICollectionViewFlowLayout.init();
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10);
        layout.itemSize = CGSize.init(width: (UIScreen.main.bounds.size.width-40)/3, height: (UIScreen.main.bounds.size.width-40)/3);
        layout.scrollDirection = UICollectionViewScrollDirection.vertical;
        _collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 64, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height-64), collectionViewLayout: layout);
        _collectionView?.register(object_getClass(ZYImageCollectionViewCell()), forCellWithReuseIdentifier: "zyitem");
        //设置滑动速度
//        _collectionView?.decelerationRate = UIScrollViewDecelerationRateFast;
        _collectionView?.delegate = self;
        _collectionView?.dataSource = self;
        _collectionView?.backgroundColor = UIColor.lightGray;
        self.view.addSubview(_collectionView!);
        loadData();
    }
    
    //取消按钮
    func cancelBarItemAction(item:UIBarButtonItem){
        self.dismiss(animated: true, completion: nil);
    }
    //确定按钮
    func sureBarItemAction(item:UIBarButtonItem){
        self.dismiss(animated: true, completion: nil);
        if selectImageFaction != nil {
            selectImageFaction!(selectedArray!);
        }
        
    }
    //dataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if dataArray == nil {
            return 0;
        }
        return (dataArray?.count)!;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "zyitem", for: indexPath) as? ZYImageCollectionViewCell;
        cell?.imageV?.image = dataArray?[indexPath.row];
        if (selectedArray?.contains((cell?.imageV?.image)!))! == true{
            cell?.selectedImageV?.isHidden = false;
        }else{
            cell?.selectedImageV?.isHidden = true;
        }
        return cell!;
    }
    //delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let cell = collectionView.cellForItem(at: indexPath) as? ZYImageCollectionViewCell;
        if cell?.selectedImageV?.isHidden == true{
            if (selectedArray?.count)! >= maxCount {
                self.showAlert(title: "图片超过数量", message: "无法再选取");
                return;
            }
        }
        
        cell?.selectedImageV?.isHidden = !(cell?.selectedImageV?.isHidden)!;
        if cell?.selectedImageV?.isHidden == false{
            selectedArray?.append((dataArray?[indexPath.row])!);
        }else{
            var i = 0;
            for asset in selectedArray!{
                if asset == dataArray?[indexPath.row]{
                    selectedArray?.remove(at: i);
                    return;
                }
                i = i + 1;
            }
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    func loadData(){
        ZYImageManager.GetAllImagePhasset { (asetArray) in
            self.selectedArray = Array.init();
            self.dataArray = asetArray;
            self._collectionView?.reloadData();
        }
    }

}
