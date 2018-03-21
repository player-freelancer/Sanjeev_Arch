//
//  OTFile.swift
//
//  Created by Raj on 05/01/17.
//  Copyright © 2017 MR. All rights reserved.
//

import Foundation
import UIKit


let con_authapp_auth    = "F$KkrLHrceU3WQ5c-7SGG8vZGhj2qfJek"
let con_user_session_id = "con_user_session_id";
let kPostMethod         = "POST";
let kContentType        = "application/json";
let kContentTypeName    = "Content-Type";
let kAdmAppAuthName     = "Adm-App-Auth";
let kAdmSessionIDName   = "Adm-Session-ID";
let kContentLengthName  = "Content-Length";
let kResponseDataKey    = "responseData";
let kStatusCodeKey      = "statusCode";

let mediaTranscodeUrl   = "/transcode/wmap/"
let mediaTranscode360Url = "/transcode/three60-preview"


//NitificationCenter Names

let updateApartmentInfoOnEditDetail = "updateApartmentInfo"
let updateApartmentInfoOnPreviewListing = "updateApartmentInfoInPreviewListing"
let PBNotificationListingChanged = "PBNotificationListingChanged"
let PBNotificationKeyListing = "PBNotificationKeyListing"

let tostTimeToShow = 1.0

var timeZoneServer = "America/New_York"

var timerSignUp : Timer?

//var dictUserInfo = [String : AnyObject]()

var dictSearchOptions = [String : AnyObject]()

var arrAppointmentList = [[String: AnyObject]]()

var dictAppointmentDashBoard = [String: AnyObject]()

var dictNewListingDashBoard = [String: AnyObject]()

// Params:
//  AlertsList
//  ListCount

var dictAlertDashBoard = [String: AnyObject]()

// Params:
//  ClientsList
//  ListCount

var dictClientsDashBoard = [String: AnyObject]()


var dictForApartmentOptions = [String: AnyObject]()

class CommonFile: NSObject {
//
//    let hud = MBProgressHUD()
    
   /// let navigation = NavigationVC()
    
    static let shared : CommonFile = {
        
        let instance = CommonFile()
        
        return instance
    }()
    
    /*
    func hudShow(strText: String?) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        hud.show(true)
        
        if let strLoaderString = strText {
           
            hud.labelText = strLoaderString
        }
        
        hud.frame = (appDelegate.window?.frame)!
        
        hud.backgroundColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.70)
        
        hud.color = UIColor.clear
        
        appDelegate.window?.addSubview(hud)
    }
 
    
    func hudDismiss() {
        
        DispatchQueue.main.async {
        
            self.hud.removeFromSuperview()
        }
    }
 */
    
    
    func heightCalculate(arrCount: Int, numberOfColumn: Int, heightOfCell: Int) -> CGFloat {
        
        var numberOfRow = arrCount / numberOfColumn
        
        let reminder = arrCount % numberOfColumn
        
        if reminder != 0 {
            
            numberOfRow = Int(numberOfRow + 1)
        }
        
        return CGFloat((numberOfRow * heightOfCell) + 30)
    }
    
    
    func saveUserDetails(dictUserDetail: [String: AnyObject]) -> Void {
        
        let dataExample: Data = NSKeyedArchiver.archivedData(withRootObject: dictUserDetail)
    
        UserDefaults.standard.set(dictUserDetail["user_id"] as! String, forKey: "user_id")
        
        UserDefaults.standard.set(dataExample, forKey: "kUserDetails")
        
        UserDefaults.standard.synchronize()
    }
    
    
    func getUserDetails() -> [String: AnyObject] {
        
        let dataUserDetails = UserDefaults.standard.value(forKey: "kUserDetails") as! Data
        
        let dictionary = NSKeyedUnarchiver.unarchiveObject(with: dataUserDetails) as! [String : AnyObject]
        
        return dictionary
    }
    
    
    func getFavs() -> [[String: AnyObject]] {
        
        var arrFav = [[String: AnyObject]]()
        
        if let dataUserDetails = UserDefaults.standard.value(forKey: "kFav") as? Data {
            
            arrFav = NSKeyedUnarchiver.unarchiveObject(with: dataUserDetails) as! [[String: AnyObject]]
        }
        
        return arrFav
    }
    
    
    func setFavInUserDefualt(arrFav: [[String: AnyObject]]) -> Void {
        
        let dataFav: Data = NSKeyedArchiver.archivedData(withRootObject: arrFav)
        
        UserDefaults.standard.set(dataFav, forKey: "kFav")
        
        UserDefaults.standard.synchronize()
    }
    
    
    //MARK: Track save 360 image in background
    func saveInBachgroundAndTrack360ImageUserDetails(keyRoomId: String, valueAdvId: String) -> Void {
        
        var dict360ImagesSaveInBackground = [String: AnyObject]()
        
        dict360ImagesSaveInBackground = self.get360ImagesDetail()
        
        dict360ImagesSaveInBackground["\(keyRoomId)\(valueAdvId)"] = valueAdvId as AnyObject
        
        let dataExample: Data = NSKeyedArchiver.archivedData(withRootObject: dict360ImagesSaveInBackground)
        
        UserDefaults.standard.set(dataExample, forKey: "k360Image")
        
        UserDefaults.standard.synchronize()
    }
    
    
    func get360ImagesDetail() -> [String: AnyObject] {
        
        var dictionary = [String: AnyObject]()
        
        if let dataUserDetails = UserDefaults.standard.value(forKey: "k360Image") as? Data {
            
            print(dataUserDetails)
            
            if let dict = NSKeyedUnarchiver.unarchiveObject(with: dataUserDetails) as? [String : AnyObject] {
             
                dictionary = dict
            }
            
            return dictionary
        }
        
        return dictionary
    }
    
    
    func remove360ImageInBackgroundProcess(keyRoomId: String, valueAdvId: String) -> Void {
        
        var dict360ImagesSaveInBackground = [String: AnyObject]()
        
        dict360ImagesSaveInBackground = self.get360ImagesDetail()
        
        if let getValue = dict360ImagesSaveInBackground["\(keyRoomId)\(valueAdvId)"] as? String, getValue == valueAdvId {
            
            print(dict360ImagesSaveInBackground)
            
            dict360ImagesSaveInBackground.removeValue(forKey: "\(keyRoomId)\(valueAdvId)")
            
            print(dict360ImagesSaveInBackground)
            
            let dataExample: Data = NSKeyedArchiver.archivedData(withRootObject: dict360ImagesSaveInBackground)
            
            UserDefaults.standard.set(dataExample, forKey: "k360Image")
            
            UserDefaults.standard.synchronize()
        }
    }
    
    
    func check360ImageInBackgroundProcess(keyRoomId: String, valueAdvId: String) -> Bool {
        
        var dict360ImagesSaveInBackground = [String: AnyObject]()
        
        dict360ImagesSaveInBackground = self.get360ImagesDetail()
        
        if let getValue = dict360ImagesSaveInBackground["\(keyRoomId)\(valueAdvId)"] as? String, getValue == valueAdvId {
            
            return true
        }
        
        return false
    }
    
    //MARK:- Activity Indicator
    func activityIndicatorView() -> UIActivityIndicatorView {
        
        let pagingSpinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        
        pagingSpinner.frame = CGRect(x: 0, y: 0, width: DeviceInfo.TheCurrentDeviceWidth, height: 40)
        
        pagingSpinner.stopAnimating()
        
        pagingSpinner.color = UIColor.colorTheme()
        
        pagingSpinner.hidesWhenStopped = true
        
        return pagingSpinner
    }
    
    
    /*
    //MARK:- Set Profile Image
    func setProfileImage(imgView : UIImageView, photoUrl : String, strSubUrl: String) -> Void {
        
        imgView.isHidden = false
        
        imgView.layer.cornerRadius = imgView.frame.size.width/2
        
        if !photoUrl.isEmpty {
            
            imgView.setShowActivityIndicator(true)
            
            imgView.setIndicatorStyle(.gray)
            
            let imgBaseURL = String(format: "%@", UserDefaults.standard.value(forKey: "image_url") as! String)
            
//            /transcode/wmap/
            
//            /transcode/mcontact/user/
            
            imgView.sd_setImage(with: URL(string: "\(imgBaseURL)\(strSubUrl)\(photoUrl)")) { (image, error, cache, urls) in
                
                if let _: Error = error  {
                    
                    imgView.image = UIImage(named: "placeHolderProfilePic")
                }
                else {
                    
                    imgView.image = image
                }
            }
        }
        else {
            
            imgView.image = UIImage(named: "placeHolderProfilePic")
        }
    }
    
    
    
    //MARK:- Set Listing Image
    func setListingImage(imgView : UIImageView, photoUrl : String, strSubUrl: String) -> Void {
        
        imgView.isHidden = false
        
        if !photoUrl.isEmpty {
            
            imgView.setShowActivityIndicator(true)
            
            imgView.setIndicatorStyle(.white)
            
            let imgBaseURL = String(format: "%@", UserDefaults.standard.value(forKey: "image_url") as! String)
            
            //            /transcode/wmap/
            
            //            /transcode/mcontact/user/
            
            imgView.sd_setImage(with: URL(string: "\(imgBaseURL)\(strSubUrl)\(photoUrl)")) { (image, error, cache, urls) in
                
                if let _: Error = error  {
                    
                    imgView.image = UIImage(named: "no-images-placeholder")
                }
                else {
                    
                    imgView.image = image
                }
            }
        }
        else {
            
            imgView.image = UIImage(named: "no-images-placeholder")
        }
    }
    */
    
    //MARK:- Get String Size
    func stringSize(text : String, width: CGFloat, font: UIFont) -> CGSize {
        
        let maxSize = CGSize(width: Int(width), height: Int.max)
        
        let size = (text as NSString).boundingRect(with: maxSize,
                                                   options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                   attributes: [NSAttributedStringKey.font:font],
                                                   context: nil).size
        
        return size
    }
    
    
    func stringWidthSize(text : String, height: CGFloat, font: UIFont) -> CGSize {
        
        let maxSize = CGSize(width: Int.max, height: Int(height))
        
        let size = (text as NSString).boundingRect(with: maxSize,
                                                   options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                   attributes: [NSAttributedStringKey.font:font],
                                                   context: nil).size
        
        return size
    }
    
    
    //MARK:- Calculate String Height
    func heightForString(str: String) -> CGSize {
        
        let maxLabelSize: CGSize = CGSize(width: DeviceInfo.TheCurrentDeviceWidth * 0.65, height:  CGFloat(9999))
        
        let contentNSString = str as NSString
        
        let expectedLabelSize = contentNSString.boundingRect(with: maxLabelSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: UIFont.fontLatoRegulat15()], context: nil)
        
        return expectedLabelSize.size
    }
    
    //MARK: - Start & end Date
     func getCalendarComponent(date: Date) -> NSDateComponents {
        
        let calendarGregorian = Calendar(identifier: .gregorian)
        
        return calendarGregorian.dateComponents([.hour, .minute], from: date as Date) as NSDateComponents!
    }
    
    
    func getStartAndEndDateTime(strSelectedDate: String) -> [Date] {
        
        let today = Date()
        
        let comps : NSDateComponents = self.getCalendarComponent(date: today)
        
        var hour : Int = comps.hour
        
        var minute : Int = comps.minute
        
        if (minute>00 && minute<15) {
            minute=15;
        }
        else if (minute>15 && minute<30) {
            minute=30;
        }
        else if (minute>30 && minute<45) {
            minute=45;
        }
        else if (minute>45 && minute<=59) {
            minute=00;
            
            hour = hour+1
        }
        
        let strMinute = minute == 0 ? "00" : "\(minute)"
        
        let strStartDate = "\(strSelectedDate) \(hour):\(strMinute)"
        
        let strEndDate = "\(strSelectedDate) \(hour+1):\(strMinute)"
        
        let startDate = TimeStatus.getDate(strDate: strStartDate, oldFormatter: "MMM dd, yyyy HH:mm")
        
        let endDate = TimeStatus.getDate(strDate: strEndDate, oldFormatter: "MMM dd, yyyy HH:mm")
        
        return [startDate, endDate]
    }
    
    
    //MARK: - Get Document Directory Path
    func getDocumentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let documentsDirectory = paths[0]
        
        return documentsDirectory
    }
    
    
    func deleteAllImageFromDocumentDirectory(arrAllImage: [[String: AnyObject]]) -> Void {
        
        DispatchQueue.global(qos: .background).async {
            
            for item in arrAllImage {
                
                if let strReady = item["ready"] as? String {
                    
                    if strReady == "0" {
                        
                        let imageURL = URL(fileURLWithPath: item["path"] as! String)
                        
                        let fileManager = FileManager.default
                        
                        do {
                            try fileManager.removeItem(atPath: imageURL.path)
                            
                        } catch let error as NSError {
                            
                            print("Error ::: \(error.debugDescription)")
                        }
                    }
                }
            }
        }
    }
    
    
    func getCellHeight(dictFiltered: [String: AnyObject]) -> CGFloat {
        
        var height: CGFloat = 30.0
        
        if let roomFeatures = dictFiltered["features"] as? [String] {
            
            height = height + (CGFloat(roomFeatures.count) * CGFloat(25.0))
        }
        
        return height
    }
    
    
    func getHighestHeightOf3Pair(arrAllRoomsInfo: [[String: AnyObject]]) -> CGFloat {
        
        var arrRowHeightL = [CGFloat]()
        
        for item in arrAllRoomsInfo {
            
            arrRowHeightL.append(self.getCellHeight(dictFiltered: item))
        }
        
        var getMaxheightTotal: CGFloat = 0.0
        
        var getIndex:Int = 10000
        
        for i in 0..<arrRowHeightL.count {
            
            let a = i / 3
            
            let index = a * 3
            
            if (a * 3) == getIndex {
                
                continue
            }
            
            getIndex = a * 3
            
            var column1: CGFloat = 0.0
            var column2: CGFloat = 0.0
            var column3: CGFloat = 0.0
            
            var maxHeight: CGFloat = 0.0
            
            if index < arrRowHeightL.count {
                
                column1 = arrRowHeightL[getIndex]
            }
            
            if index+1 < arrRowHeightL.count {
                
                column2 = arrRowHeightL[getIndex+1]
            }
            
            if index+2 < arrRowHeightL.count {
                
                column3 = arrRowHeightL[getIndex+2]
            }
            
            maxHeight = max(column1, column2, column3)
            
            getMaxheightTotal = getMaxheightTotal + maxHeight
        }
        
        return getMaxheightTotal
    }
    
    
    func animationScaling(view: UIView) -> Void {
        
//        UIView.animate(withDuration: 0.2,
//               animations: {
//                view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
//        },
//               completion: { _ in
//                UIView.animate(withDuration: 0.2) {
//                    view.transform = CGAffineTransform.identity
//                }
//        })
    }
}


struct TimeStatus {
    
    static func getStrDateCallWithDate(isApplyTimeZone: Bool, date: Date , newFormat: String) -> String {
        
        let edtDf = DateFormatter()
        
        if isApplyTimeZone == true {
            
//            edtDf.timeZone = TimeZone(identifier: "UTC")
//            
//            edtDf.locale = Locale.current
        }
        
        edtDf.timeZone = TimeZone.current
        
        edtDf.dateFormat = newFormat
        
        let strNewDate = edtDf.string(from: date)
        
        return strNewDate
    }
    
    
    static func getDate(isApplyTimeZone: Bool, strDate: String, oldFormatter: String, newFormat: String) -> String {
        
        let dateStr = strDate;
        
        let dateFormat = DateFormatter()
        
//                let timeZone = TimeZone.current
//        
//                dateFormat.timeZone = timeZone
        
        dateFormat.dateFormat = oldFormatter
        
        let date = dateFormat.date(from: dateStr)
        
        let strNewDate = self.getStrDateCallWithDate(isApplyTimeZone: isApplyTimeZone, date: date!, newFormat: newFormat)
        
        return strNewDate
    }
    
    static func getDate(strDate: String, oldFormatter: String) -> Date {
        
        let dateStr = strDate;
        
        let dateFormat = DateFormatter()
        
//        dateFormat.amSymbol = "AM"
//        dateFormat.pmSymbol = "PM"
        
//        let timeZone = TimeZone(identifier: "UTC")
//
//        dateFormat.timeZone = timeZone
        
        dateFormat.dateFormat = oldFormatter
        
        return dateFormat.date(from: dateStr)!
    }
}


struct ValidAlertTitle {
    
    static let FieldMandatory = "All fields are mandatory"
    
    static let Warning = "Warning!"
    
    static let Error = "Error!"
    
    static let ForgotPasswordAlertTitle = "An email has been sent to your email address with a new password. Please check your email."
    
    static let fbTitle = "Server error"
}


struct ValidAlertMsg {
    
    static let FieldMandatory = "Please enter all values and try again."
    
    static let EnterEmail = "Please enter email."
    
    static let EnterValidEmail = "Please enter valid email."
    
    static let EmailNotExist = "The entered email address is not associated with any existing account. Please sign up for a new account."
    
    static let fbMsg = "There was a server error. Please check with server admin for further details."
}


extension UIView {
    
    var parentViewController: UIViewController? {
        
        var parentResponder: UIResponder? = self
        
        while parentResponder != nil {
            
            parentResponder = parentResponder!.next
            
            if let viewController = parentResponder as? UIViewController {
                
                return viewController
            }
        }
        return nil
    }
}

public extension CGFloat {
    /**
     * Converts an angle in degrees to radians.
     */
    public func degreesToRadians() -> CGFloat {
        return 180.0
    }
}

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date)) Year"   }
        if months(from: date)  > 0 { return "\(months(from: date)) Mon"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date)) Week"   }
        if days(from: date)    > 0 { return "\(days(from: date)) Day"    }
        if hours(from: date)   > 0 { return "\(hours(from: date)) Hr"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date)) Min" }
        if seconds(from: date) > 0 { return "\(seconds(from: date)) Sec" }
        return ""
    }
}

/*
extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}*/

