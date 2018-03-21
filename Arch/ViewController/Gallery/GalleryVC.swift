//
//  GalleryVC.swift
//  Arch
//
//  Created by Macbook on 3/12/18.
//  Copyright © 2018 RP. All rights reserved.
//

import UIKit
import PhotosUI

class GalleryVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectioViewGallery: UICollectionView!
    
    var images = [UIImage]()
    
    var btnMenu: UIBarButtonItem!
    
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        collectioViewGallery.register(UINib(nibName: "GalleryCVCell", bundle: nil), forCellWithReuseIdentifier: "galleryCVCell")
        
        self.navigationView()
        
        FetchCustomAlbumPhotos()
    }

    override func didReceiveMemoryWarning() {
     
        super.didReceiveMemoryWarning()
    }

    
    func navigationView() -> Void {
        
        self.navigationController?.navigationBar.makeColorNavigationBar()
        
        self.navigationItem.navTitle(title: "Gallery")
        
        self.navigationController?.navigationBar.makeColorNavigationBar()
        
        btnMenu = UIBarButtonItem(image: #imageLiteral(resourceName: "menuIcon"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(btnMenuAction))
        
        //        btnFilterShipment = UIBarButtonItem(image: #imageLiteral(resourceName: "filterIcon"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(btnFilterShipmentAction(sender:)))
        
        self.navigationItem.leftBarButtonItem = btnMenu
        
        //        self.navigationItem.rightButton(btn: btnFilterShipment)
    }
    
    @IBAction func btnMenuAction(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        if self.navigationController?.view.frame.origin.x == 0 {
            
            UIView.animate(withDuration: 0.4) {
                
                self.navigationController?.view.frame = CGRect(x: DeviceInfo.TheCurrentDeviceWidth / 1.5, y: 0, width: self.view.frame.size.width, height: DeviceInfo.TheCurrentDeviceHeight)
                
                //                self.btnLeftSlider.isHidden = false
            }
        }
        else {
            
            UIView.animate(withDuration: 0.4) {
                
                self.navigationController?.view.frame = CGRect(x: 0, y: 0, width: DeviceInfo.TheCurrentDeviceWidth, height: DeviceInfo.TheCurrentDeviceHeight)
                
                //                self.btnLeftSlider.isHidden = true
            }
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("gallery count : \(self.arrayGallerySingle.count)")
        return 20
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCVCell", for: indexPath) as! GalleryCVCell
        
        cell.imgGallery.image = UIImage(named: "WhatsApp\(indexPath.row).jpeg")
//        if let imgUrl = arrayGallerySingle[indexPath.row] as? String {
//            if let url = NSURL(string: imgUrl) {
//                cell.galleryImage?.sd_setImage(with: url as URL, placeholderImage: UIImage(named: "place holder image"), options: .lowPriority)
//            }
//            else{
//                let alertController = UIAlertController(title: "No Gallery Images", message: "test", preferredStyle: .alert)
//                let okButton = UIAlertAction(title: "Okay", style: .default, handler: nil)
//                alertController.addAction(okButton)
//                alertController.present(alertController, animated: true, completion: nil)
//            }
//        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width/2 , height: collectionView.frame.size.height/3 )
        
    }
    
    
    
    func FetchCustomAlbumPhotos()
    {
        var albumName = "Rah"
        var assetCollection = PHAssetCollection()
        var albumFound = Bool()
        var photoAssets = PHFetchResult<AnyObject>()
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
        let collection:PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        
        print(collection.count)
        
        if let first_Obj:AnyObject = collection.firstObject{
            //found the album
            assetCollection = collection.firstObject as! PHAssetCollection
            albumFound = true
        }
        else { albumFound = false }
        var i = collection.count
        photoAssets = PHAsset.fetchAssets(in: assetCollection, options: nil) as! PHFetchResult<AnyObject>
        let imageManager = PHCachingImageManager()
        
        //        let imageManager = PHImageManager.defaultManager()
        
        photoAssets.enumerateObjects{(object: AnyObject!,
            count: Int,
            stop: UnsafeMutablePointer<ObjCBool>) in
            
            if object is PHAsset{
                let asset = object as! PHAsset
                print("Inside  If object is PHAsset, This is number 1")
                
                let imageSize = CGSize(width: asset.pixelWidth,
                                       height: asset.pixelHeight)
                
                /* For faster performance, and maybe degraded image */
                let options = PHImageRequestOptions()
                options.deliveryMode = .fastFormat
                options.isSynchronous = true
                
                imageManager.requestImage(for: asset,
                                                  targetSize: imageSize,
                                                  contentMode: .aspectFill,
                                                  options: options,
                                                  resultHandler: {
                                                    (image, info) -> Void in
//                                                    self.photo = image!
                                                    /* The image is now available to us */
                                                    self.addImgToArray(uploadImage: image!)
                                                    print("enum for image, This is number 2")
                                                    
                })
                
            }
        }
    }

    
    func addImgToArray(uploadImage:UIImage)
    {
        self.images.append(uploadImage)
        
    }
    
}
