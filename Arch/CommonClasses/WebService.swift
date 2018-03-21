//
//  WebService.swift
//  Raj
//
//  Created by Raj on 01/06/16.
//  Copyright © 2016 Raj. All rights reserved.
//

var baseURL = "https://app-api.pocketbroker.co/v1/plist"

import UIKit

class WebService: NSObject {
    
    static let sharedInstance : WebService = {
        let instance = WebService()
        return instance
    }()
    
    //////////////////////////////////////////////////
    //************** GET API Section **************//
    //////////////////////////////////////////////////
    
    //MARK:- Post API Methods
    func getMethedWithoutParams(_ strServiceType: String?,completionHandler:@escaping (_ dict : [String: AnyObject]) -> Void, failure:@escaping (_ error :String) -> Void) -> Void {
        
        let strURL = "\(baseURL)\(strServiceType!)"
        
        let request : NSURLRequest = self.createGetRequest(url: strURL)
        
        self.callAPI(request: request, completionHandler: { (responseDict) in
            
                completionHandler(responseDict)
            
            }, failure: { (error) in
                
                failure(error)
        })
    }
    
    
    func getMethodWithParams(_ strServiceType: String, dict: [String: AnyObject], completionHandler:@escaping (_ dict: [String: AnyObject]) -> Void, failure:@escaping (_ error: String) -> Void) -> Void {
        
        var strUrl = String()
        
        strUrl = strUrl.createUrlForGetMethodWithParams(dict: dict)
        
        strUrl = "\(baseURL)\(strServiceType)\(strUrl)"
        
        let request : NSURLRequest = self.createGetRequest(url: strUrl)
        
        self.callAPI(request: request, completionHandler: { (responseDict) in
            
                completionHandler(responseDict)
            
            }, failure: { (error) in
                
                failure(error)
        })
    }
    
    
    private func createGetRequest(url: String) -> NSURLRequest {
        
        let urlPath = NSURL(string: url)
        
        let request = NSMutableURLRequest(url: urlPath! as URL)
        
        request.timeoutInterval = 60
        
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        
//        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "GET"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.setValue(con_authapp_auth, forHTTPHeaderField: "Adm-App-Auth")
        
        request.setValue("no-cache", forHTTPHeaderField: "Cache-Control")
        
        if let sessionId = UserDefaults.standard.value(forKey: "kSessionId") as? String {
            
            request.setValue(sessionId, forHTTPHeaderField: "Adm-Session-ID")
        }
        else {
            
            request.setValue(nil, forHTTPHeaderField: "Adm-Session-ID")
        }
        
        return request
    }
    
    
    //////////////////////////////////////////////////
    //************** Delete API Section **************//
    //////////////////////////////////////////////////
    
    //MARK:- Delete API Methods
    func deleteMethodWithJsonParams(strURL: String, dict:[String: AnyObject], completionHandler:@escaping (_ dict :[String: AnyObject]) -> Void, failure:@escaping (_ errorMsg : String) -> Void) -> Void {
        
        let request = self.requestPostWithJsonData(method: "DELETE")
        
        let requestWithParam = self.attachedJSonDataWithRequestBody(request: request, dictParam: dict)
        
        self.callAPI(request: requestWithParam, completionHandler: { (responseDict) in
            
            completionHandler(responseDict)
        }, failure: { (error) in
            
            failure(error)
        })
    }
    
    //////////////////////////////////////////////////
    //************** PUT API Section **************//
    //////////////////////////////////////////////////
    
    //MARK:- Put API Methods
    func putMethodWithJsonParams(strURL: String, dictParam:[String: AnyObject], completionHandler:@escaping (_ dict :[String: AnyObject]) -> Void, failure:@escaping (_ errorMsg : String) -> Void) -> Void {
        
        let request = self.requestPostWithJsonData(method: "PUT")
        
        let requestWithParam = self.attachedJSonDataWithRequestBody(request: request, dictParam: dictParam)
        
        self.callAPI(request: requestWithParam, completionHandler: { (responseDict) in
            
            completionHandler(responseDict)
        }, failure: { (error) in
            
            failure(error)
        })
    }
    
    
    //////////////////////////////////////////////////
    //************** POST API Section **************//
    //////////////////////////////////////////////////
    
    //MARK:- Post API Methods
    func postMethodWithJsonParams(strURL: String, dict:[String: AnyObject], completionHandler:@escaping (_ dict :[String: AnyObject]) -> Void, failure:@escaping (_ errorMsg : String) -> Void) -> Void {
        
        let request = self.requestPostWithJsonData(method: "POST")
        
        let requestWithParam = self.attachedJSonDataWithRequestBody(request: request, dictParam: dict)
        
        self.callAPI(request: requestWithParam, completionHandler: { (responseDict) in
            
            completionHandler(responseDict)
        }, failure: { (error) in
            
            failure(error)
        })
    }
    
    
    func postMethodWithParams(strURL: String, dict:[String: AnyObject], completionHandler:@escaping (_ dict :[String: AnyObject]) -> Void, failure:@escaping (_ errorMsg : String) -> Void) -> Void {
        
        let request = self.PostWithParamAndImage(strURL: strURL, dictParam: dict, file: nil, fileKey: nil, fileName: nil)
        
        self.callAPI(request: request, completionHandler: { (responseDict) in
            
                completionHandler(responseDict)
            }, failure: { (error) in
                
                failure(error)
        })
    }
    
    
    func postMethodWithParamsAndImage(strURL: String, dictParams: [String: AnyObject], image: UIImage?, imagesKey: String, imageName: String, completionHandler:@escaping (_ dict :[String: AnyObject]) -> Void, failue:@escaping (_ error: String) -> Void) {
        
        let request = self.PostWithParamAndImage(strURL: strURL, dictParam: dictParams, file: image, fileKey: imagesKey, fileName: imageName)
        
        self.callAPI(request: request, completionHandler: { (responseDict) in
            
                completionHandler(responseDict)
            }, failure: { (error) in
                
                failue(error)
        })
    }
    
    
    func requestPostWithJsonData(method: String) -> NSMutableURLRequest {
        
        let myUrl = URL(string: "\(baseURL)") // Replace with base url
        
        let request = NSMutableURLRequest(url:myUrl!)
        
        request.httpMethod = method.capitalized;
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.setValue(con_authapp_auth, forHTTPHeaderField: "Adm-App-Auth")
        
        if let sessionId = UserDefaults.standard.value(forKey: "kSessionId") as? String {
            
            request.setValue(sessionId, forHTTPHeaderField: "Adm-Session-ID")
        }
        else {
            
            request.setValue(nil, forHTTPHeaderField: "Adm-Session-ID")
        }
       
        return request
    }
    
    
    func attachedJSonDataWithRequestBody(request: NSMutableURLRequest, dictParam:[String: AnyObject]) -> NSMutableURLRequest {
        
        if !dictParam.isEmpty {
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: dictParam, options: .prettyPrinted)
                
//                let theJSONText = NSString(data: jsonData, encoding: String.Encoding.ascii.rawValue)
//                print("JSON string = \(theJSONText!)")
                
                request.setValue(String(format: "%ul", (jsonData as NSData).length), forHTTPHeaderField: kContentLengthName)
                
                request.httpBody = jsonData
            } catch {
         
                print("Error :::-- \(error.localizedDescription)")
            }
        }
        
        return request
    }
    
    
    private func PostWithParamAndImage(strURL: String, dictParam: [String: AnyObject], file: UIImage?, fileKey: String?, fileName: String?) -> NSURLRequest
    {
        let myUrl = URL(string: "\(baseURL)\(strURL)") // Replace with base url
        
        let request = NSMutableURLRequest(url:myUrl!)
        
        request.httpMethod = "POST";
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        request.setValue(con_authapp_auth, forHTTPHeaderField: "Adm-App-Auth")
        
        if let sessionId = UserDefaults.standard.value(forKey: "kSessionId") as? String {
            
            request.setValue(sessionId, forHTTPHeaderField: "Adm-Session-ID")
        }
        else {
            
            request.setValue(nil, forHTTPHeaderField: "Adm-Session-ID")
        }
        
        if file != nil {
            
            let imageData = UIImageJPEGRepresentation(file!, 0.8)
            
            request.httpBody = createBodyWithParametersAndImage(parameters: dictParam, filePathKey: fileKey!, fileName: fileName!, imageDataKey: imageData! as NSData, boundary: boundary) as Data
        }
        else {
            
            request.httpBody = createBodyWithParameters(parameters: dictParam, boundary: boundary) as Data
        }
        
        return request;
    }
    
    /*
    private func PostWithParamAndImage(strURL: String,dictParam: [String: AnyObject], file: UIImage?, fileKey: String?, fileName: String?) -> NSURLRequest
    {
        let myUrl = URL(string: "\(baseURL)\(strURL)") // Replace with base url
        
        let request = NSMutableURLRequest(url:myUrl!)
        
        request.httpMethod = "POST";
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.setValue(con_authapp_auth, forHTTPHeaderField: "Adm-App-Auth")
        
        request.setValue(nil, forHTTPHeaderField: "Adm-Session-ID")

        
        if file != nil
        {
//            let imageData = UIImageJPEGRepresentation(file!, 1)
            
//            request.httpBody = createBodyWithParametersAndImage(parameters: dictParam, filePathKey: fileKey!, fileName: fileName!, imageDataKey: imageData! as NSData, boundary: boundary) as Data
        }
        else
        {
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: dictParam, options: .prettyPrinted)
                
                request.setValue(String(format: "%ul", (jsonData as NSData).length), forHTTPHeaderField: kContentLengthName)
                
                request.httpBody = jsonData
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return request;
    }
    */
    
    private func createBodyWithParametersAndImage(parameters: [String: AnyObject], filePathKey: String?, fileName: String?, imageDataKey: NSData, boundary: String) -> NSData {
        
        let body = NSMutableData();
        
        for (key, value) in parameters {
            
            body.appendString(string: "--\(boundary)\r\n")
            
            body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            
            body.appendString(string: "\(value)\r\n")
        }
        
        let filename = "\(fileName!).jpg"
        
        let mimetype = "image/jpg"
        
        body.appendString(string: "--\(boundary)\r\n")
        
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        
        body.append(imageDataKey as Data)
        
        body.appendString(string: "\r\n")
        
        body.appendString(string: "--\(boundary)--\r\n")
        
        return body
    }
    
    
    private func createBodyWithParameters(parameters: [String: AnyObject], boundary: String) -> NSData {
        
        let body = NSMutableData();
        
        for (key, value) in parameters {
            
            body.appendString(string: "--\(boundary)\r\n")
            
            body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString(string: "\(value)\r\n")
        }
        
        body.appendString(string: "--\(boundary)--\r\n")
        
        return body
    }
    
    
    private func generateBoundaryString() -> String {
        
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    
    //MARK:- Common For Both (GET & POST)
    private func callAPI(request: NSURLRequest, completionHandler:@escaping (_ responseDict: [String: AnyObject]) -> Void, failure:@escaping (_ error: String) -> Void) -> Void {
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            
            guard error == nil && data != nil else {
                
                failure(error!.localizedDescription)
                
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse , httpStatus.statusCode == 200 {
                
                do {                    
                    
                    if httpStatus.allHeaderFields["Content-Type"] as! String == "application/x-plist" {
                    
                         let plist1 = try PropertyListSerialization.propertyList(from: data!, options: .mutableContainersAndLeaves, format: nil) as! [String: AnyObject]
                        
                        completionHandler(plist1)
                    }
                    else {
                        
                        if let result = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject] {
                            
                            completionHandler(result )
                        }
                        else {
                            
                            var resultCount = "0"
                            
                            if let countList = httpStatus.allHeaderFields["Adm-Result-Total-Count"] as? String {
                                
                                resultCount = countList
                            }
                            
                            let result = try JSONSerialization.jsonObject(with: data!, options: []) as? [Dictionary<String, AnyObject>]
                            
                            completionHandler(["result" : result as AnyObject,
                                               "resultCount" : resultCount as AnyObject] )
                        }
                    }
                } catch let error as NSError {
                    
                    failure("json error: \(error.localizedDescription)")
                }
            }
            else {
                
                let httpStatus = response as? HTTPURLResponse
                
                failure(String(format: "%d", (httpStatus?.statusCode)!))
                
                /*
                if !(data?.isEmpty)! {
                    
                    do {
                        
                        let result = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: AnyObject]
                        
                        if let errorMsg = result["errorMsg"] as? String {
                            
                            if errorMsg.validErrorMsg() {
                                
                                failure("errorMsg \(errorMsg)")
                            }
                            else {
                                
                                let httpStatus = response as? HTTPURLResponse
                                
                                failure("API Response status code : \(httpStatus?.statusCode)")
                            }
                        }
                        else {
                            let httpStatus = response as? HTTPURLResponse
                            
                            failure("API Response status code : \(httpStatus?.statusCode)")
                        }
                    }
                    catch {
                        
                        let httpStatus = response as? HTTPURLResponse
                        
                        failure("API Response status code : \(httpStatus?.statusCode)")
                    }
                }
                else {
                    
                    let httpStatus = response as? HTTPURLResponse
                    
                    failure("API Response status code : \(httpStatus?.statusCode)")
                }
 */
            }
        }
        task.resume()
    }
    
    
    
    func getPListData() -> [String: AnyObject] {
        
        var dictResponse = [String: AnyObject]()
        
        let todoEndpoint: String = baseURL
        
        guard let url = URL(string: todoEndpoint) else {
            
            print("Error: cannot create URL")
            
            return dictResponse
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest.setValue(con_authapp_auth, forHTTPHeaderField: "Adm-App-Auth")
        
        urlRequest.setValue("no-cache", forHTTPHeaderField: "Cache-Control")
        
        urlRequest.timeoutInterval = 60
        
        urlRequest.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        
        urlRequest.httpMethod = "GET"
        
        let semaphore = DispatchSemaphore(value: 0)
        
        // set up the session
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            guard error == nil && data != nil else {
                
                print("Error getPListData : \(String(describing: error?.localizedDescription))")
                
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse , httpStatus.statusCode == 200 {
                
                do {
                    
                    if httpStatus.allHeaderFields["Content-Type"] as! String == "application/x-plist" {
                        
                        let plist1 = try PropertyListSerialization.propertyList(from: data!, options: .mutableContainersAndLeaves, format: nil) as! [String: AnyObject]
                        
                        dictResponse = plist1
                    }
                    else if let result = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject] {
                        
                        dictResponse = result
                    }
                    
                }
                catch let error as NSError {
                    
                    print("json error: \(error.localizedDescription)")
                }
            }
            semaphore.signal()
        })
        task.resume()
        
        semaphore.wait(timeout: .distantFuture)
        
        print(dictResponse)
        
        if !dictResponse.isEmpty {
            
            UserDefaults.standard.setValue((dictResponse["360_base_url"] as! String), forKey: "360_base_url")
            
            UserDefaults.standard.setValue((dictResponse["auth_api_url"] as! String), forKey: "auth_api_url")
            
            UserDefaults.standard.setValue((dictResponse["agent_api_url"] as! String), forKey: "agent_base_url")
            
            UserDefaults.standard.setValue((dictResponse["media_base_url"] as! String), forKey: "image_url")
            
            UserDefaults.standard.setValue((dictResponse["one_signal_app_id"] as! String), forKey: "one_signal_app_id")
            
            UserDefaults.standard.synchronize()
        }
        
        return dictResponse
    }
}


extension NSMutableData {
    
    func appendString(string: String) {
        
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        
        append(data!)
    }
}


extension String {
    
    func createUrlForGetMethodWithParams(dict: [String: AnyObject]) -> String {
        
        var stringUrl1 = String()
        
        var firstTime1 = "yes"
        
        for (key,value) in dict {
            
            let stringVal = value as! String
            
            if let percentEscapedString = stringVal.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
                
                if firstTime1 == "yes" {
                    
                    stringUrl1 = "?\(key)=\(percentEscapedString)"
                    
                    firstTime1 = "no"
                }
                else {
                    stringUrl1 = "\(stringUrl1)&\(key)=\(percentEscapedString)"
                }
            }
        }
        
        return stringUrl1
    }
    
}
