//
//  OTExtensionString.swift
//  Raj
//
//  Created by Raj on 10/11/16.
//  Copyright © 2016 Raj. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    func Trim() -> String {
        
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    
    func isValidEmail() -> Bool {
        
        let emailRegex: String = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
  
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailTest.evaluate(with: self)
    }
    
    
    func verifyUrl() -> Bool {
        
        if let urlString = self as? String {
            
            if let url  = NSURL(string: urlString) {
                
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    
    func validErrorMsg() -> Bool {
        
        let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: NSRegularExpression.Options())
        
        if regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(), range:NSMakeRange(0, self.count)) != nil {
            
            return false
        }
        return true
    }
    
    
    func txtPlaceHolder() -> NSMutableAttributedString {
        
        let attributes = [
            NSAttributedStringKey.font : UIFont.fontLatoBlack13(),
            NSAttributedStringKey.foregroundColor : UIColor.lightGray]
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self, attributes: attributes)
        
        return attributeString
    }
    
    
    func priceFormatter() -> String {
        
        let priceLocale = NSLocale(localeIdentifier: "en_US")
        
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        
        formatter.locale = priceLocale as Locale!
        
        formatter.maximumFractionDigits = 0
        
        let currencyString: String? = formatter.string(for: Int64(self))
        
        return currencyString!
    }
}


extension Float
{
    var cleanValue: String
    {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
