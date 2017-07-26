//
//  ZYImageManager.swift
//  ZYImageChince-Swift
//
//  Created by ybon on 2016/12/7.
//  Copyright © 2016年 ybon. All rights reserved.
//

import UIKit
import Photos
class ZYImageManager: NSObject {

    //获取相册中所有的asset对象
    class func GetAllImagePhasset(phaseFunction:@escaping (_ phasetArray:Array<UIImage>)->Void){
        let options = PHFetchOptions.init();
        options.sortDescriptors = [NSSortDescriptor.init(key: "creationDate", ascending: true)];
        let assetsFetchResults = PHAsset.fetchAssets(with: options) as PHFetchResult;
        var arr:Array<UIImage> = Array.init();
        let count = assetsFetchResults.count;
        for i in 0..<count {
            let asset = assetsFetchResults[i];
//            arr.append(asset);
            self.getImage(asset: asset, imageFunction: { (img) in
                
                arr.append(img);
                if arr.count == assetsFetchResults.count{
                    phaseFunction(arr);
                }
            })
        }
        
        
      
    }
    //获取asset对应的图片
    class func getImage(asset:PHAsset,imageFunction:@escaping (_ phasetImage:UIImage)->Void){
        
        let option = PHImageRequestOptions.init();
        option.resizeMode = PHImageRequestOptionsResizeMode.exact;
        option.isNetworkAccessAllowed = true;
        PHImageManager.default().requestImageData(for: asset, options: option) { (imageData, str, imageOrgin, info) in
            let image = UIImage.init(data: imageData!);
            let resultImage = self.imageCompressForWidthWith(sourceImage: image!, targetWidth: UIScreen.main.bounds.size.width);
            imageFunction(resultImage!);
        }
        
        
    }
    //图片压缩
    class func imageCompressForWidthWith(sourceImage:UIImage,targetWidth:CGFloat)->UIImage?{
        var newimage = UIImage.init();
        let imageSize = sourceImage.size;
        let width = imageSize.width;
        let height = imageSize.height;
        
        let targetWidthh = targetWidth;
        let targetHeight = height/width*targetWidthh;
        let size = CGSize.init(width: targetWidthh, height: targetHeight);
        var scaleFactor = 0.0;
        var scaledWidth = targetWidthh;
        var scaledHeight = targetHeight;
        var thumbnailPoint = CGPoint.init(x: 0.0, y: 0.0);
        if __CGSizeEqualToSize(imageSize, size) == false {
            let widthFactor = targetWidthh/width;
            let heightFactor = targetHeight/height;
            if widthFactor > heightFactor {
                scaleFactor = Double(widthFactor);
            }else{
                scaleFactor = Double(heightFactor);
            }
            scaledWidth = width * CGFloat(scaleFactor);
            scaledHeight = height * CGFloat(scaleFactor);
            if widthFactor > heightFactor{
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            }else{
                thumbnailPoint.x = (targetWidthh - scaledWidth) * 0.5;
            }
            
            
        }
        
        UIGraphicsBeginImageContext(size);
        var thumbnailRect = CGRect.zero;
        thumbnailRect.origin = thumbnailPoint;
        thumbnailRect.size.width = scaledWidth;
        thumbnailRect.size.height = scaledHeight;
        sourceImage.draw(in: thumbnailRect);
        newimage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        
        return newimage;
    }
    
}
