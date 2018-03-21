//
//  ContactUsVC.swift
//  Arch
//
//  Created by Macbook on 3/12/18.
//  Copyright © 2018 RP. All rights reserved.
//

import UIKit

class ContactUsVC: UIViewController {

    var btnMenu: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func navigationView() -> Void {
        
        self.navigationController?.navigationBar.makeColorNavigationBar()
        
        self.navigationItem.navTitle(title: "Contact us")
        
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
    
}
