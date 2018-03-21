//
//  NavigationVC.swift
//  LeftMenu
//
//  Created by MR on 03/02/17.
//  Copyright © 2017 MR. All rights reserved.
//

import UIKit

class NavigationVC: UINavigationController, ViewLeftMenuDelegates {

    var viewLeftMenu: ViewLeftMenu!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        viewLeftMenu = Bundle.main.loadNibNamed("ViewLeftMenu", owner: nil, options: nil)?[0] as! ViewLeftMenu
        
        viewLeftMenu.frame = CGRect(x: 0, y: 0, width: DeviceInfo.TheCurrentDeviceWidth / 1.5, height: self.view.frame.size.height)
    
        viewLeftMenu.reloadMenu()
        
        viewLeftMenu.delegates = self
        
        appDelegate.window?.addSubview(viewLeftMenu)
    
        let homeVC = HomeVC(nibName:"HomeVC",bundle:nil)
        
        self.pushViewController(homeVC, animated: false)
    }
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    
    func indexStatus(index: Int) -> Void {
        
        switch index {
            
        case 0:
            let homeVC = HomeVC (nibName: "HomeVC", bundle: nil)
            
            self.viewControllers = [homeVC]
        case 1:
            let galleryVC = GalleryVC (nibName: "GalleryVC", bundle: nil)

            self.viewControllers = [galleryVC]
            break
        case 2:
            let contactUsVC = ContactUsVC (nibName: "ContactUsVC", bundle: nil)

            self.viewControllers = [contactUsVC]
            break
        case 3:
//            let clientsVC = ClientsVC (nibName: "ClientsVC", bundle: nil)
//
//            self.viewControllers = [clientsVC]
            break
        case 4:
//            let myCalendarVC = MyCalendarVC (nibName: "MyCalendarVC", bundle: nil)
//
//            self.viewControllers = [myCalendarVC]
            break
        
        default:
            break
        }
        
        self.resetFrame()
    }
    
    
    func resetFrame() -> Void {
        
        if self.view.frame.origin.x == 0 {
            
            UIView.animate(withDuration: 0.4) {
                self.view.frame = CGRect(x: DeviceInfo.TheCurrentDeviceWidth / 1.5, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        }
        else {
            
            UIView.animate(withDuration: 0.4) {
                self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        }
    }
    
    
    func logout() -> Void {
        /*
        CommonFile.shared.hudShow(strText: "Please Wait...")
        
        UserVM.shared.deleteUserDeviceAPI { (status) in
            
            print(status)
            
            UserVM.shared.logoutApi(completionHandler: { (dictResponse) in
                
                DispatchQueue.main.async {
                    
                    CommonFile.shared.hudDismiss()
                }
            }, failure: { (error) in
                
                DispatchQueue.main.async {
                    
                    CommonFile.shared.hudDismiss()
                    
                    UserDefaults.standard.set(false, forKey: "kLogin")
                    
                    UserDefaults.standard.synchronize()
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    
                    appDelegate.setInitialVC()
                }
            })
        }*/
    }
}


extension UINavigationController {
    
    func resetVC(arrVC: [UIViewController]) -> Void {
        
        viewControllers = arrVC
    }
}


extension UINavigationItem {
    
    func leftMoreThenOneButtons(btn : UIBarButtonItem, btn2 : UIBarButtonItem) -> Void {
        
        btn.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font : UIFont(name: "HelveticaNeue", size: 18)!], for: UIControlState.normal)
        
        leftBarButtonItems = [btn, btn2]
    }
}

extension UINavigationController {
    
    func makeNavigationbar (title: String){
        
        self.navigationItem.title = title
        
        navigationController?.isNavigationBarHidden = false
    }
}


extension UINavigationBar {
    
    func makeColorNavigationBar () {
        
        isTranslucent = false
        
        barTintColor = UIColor.colorTheme()
        
        tintColor = UIColor.white
        
        titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18)]
    }
    
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        
        super.sizeThatFits(size)
        
        let sizeThatFits = super.sizeThatFits(size)
        
        //sizeThatFits.height = 56
        
        return sizeThatFits
    }
    
    
    func getCentre(imgView : UIImageView) {
        
        imgView.center = self.center
    }
}


extension UINavigationItem {
    
    func navTitle(title: String) -> Void {
        
        self.title = title
    }
    
    
    func makeNavWithImage(strImageName: String) -> Void {
        let viewNav = UIView()
        
        let imgView = UIImageView(image: UIImage(named: "strImageName"))
        
        imgView.contentMode = UIViewContentMode.scaleAspectFit
        
        imgView.center = viewNav.center
        
        viewNav.addSubview(imgView)
        
        self.titleView = viewNav
    }
    
    
    func hideDefaultBackButton() -> Void {
        
        hidesBackButton = true
    }
    
    
    func rightButton(btn : UIBarButtonItem) -> Void {
        
        btn.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.white,  NSAttributedStringKey.font : UIFont(name: "HelveticaNeue", size: 18)!], for: UIControlState.normal)
        
        rightBarButtonItem = btn
    }
}

