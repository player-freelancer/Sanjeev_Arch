//
//  ViewLeftMenu.swift
//  LeftMenu
//
//  Created by MR on 03/02/17.
//  Copyright © 2017 MR. All rights reserved.
//

protocol ViewLeftMenuDelegates {
    
    func indexStatus(index: Int)
}

import UIKit

class ViewLeftMenu: UIView, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var imgBg: UIImageView!
    
    @IBOutlet var tblMenu: UITableView!
    
    
    var delegates: ViewLeftMenuDelegates?
    
    let arrTitle = ["Home", "Gallery", "Contact us", "About us"]

    func reloadMenu() {
        
        tblMenu.frame = CGRect(x: 0, y: tblMenu.frame.origin.y, width: DeviceInfo.TheCurrentDeviceWidth / 1.5, height: tblMenu.frame.size.height)
        
        tblMenu.dataSource = self
        
        tblMenu.delegate = self
        
        tblMenu.reloadData()
    }
    
    
    // MARK: - Buttons Action
    @IBAction func btnLogoutAction(_ sender: UIButton) {
   
        UserDefaults.standard.set(false, forKey: "kLogin")

        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        appDelegate.setInitialVC()
    }
    
    
    //MARK: UITableView Delegates & Datasources
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if arrTitle.count > 0 {
            
            return arrTitle.count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell =  tableView.dequeueReusableCell(withIdentifier: "Cell") as? CustomLeftMenuTableViewCell
       
        if  (cell == nil) {
            
            let nib:NSArray = Bundle.main.loadNibNamed("CustomLeftMenuTableViewCell", owner: self, options: nil)! as NSArray
           
            cell = nib.object(at: 0)as? CustomLeftMenuTableViewCell
        }
        
        cell?.selectionStyle = .none
        
        cell?.setContents(strTitle: arrTitle[indexPath.row])
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if DeviceInfo.IS_4_INCHES() {
         
            return 44.0
        }
        
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegates?.indexStatus(index: indexPath.row)
    }
}
