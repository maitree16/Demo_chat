//
//  ServiceManager.swift
//  CLM
//
//  Created by DEVIL DECODER on 18/08/18.
//  Copyright © 2018 DECODER. All rights reserved.



import Foundation
import Alamofire
import KVNProgress
import UIKit
import Reachability

class ServiceManager
{
    
    // base url
    
    //remove capitilastion
    private(set) var Url =  ""
    private(set) var ClientVersion = ""
    private(set) var BusinessVersion = ""
    private(set) var TourUploads = ""
    private(set) var CompanyLogo = ""
    
    
    private let app = UIApplication.shared.delegate as! AppDelegate
    typealias CompletionHandler = ([[String:Any]]?)->Void
    static var shared:ServiceManager{
        get{
            struct serviceManager {
                static let manager = ServiceManager()
            }
            return serviceManager.manager
        }
    }
    
    let manager:SessionManager!
    
    init() {
        
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        config.urlCache = nil
        
        manager = Alamofire.SessionManager(configuration: config)
    }
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    //This code is pretty messy.
    //try to avoid nested if staments
    //See if you can clean it up
    // use more functions if neccessary
    func MakeApiCall(ForServiceName serviceName:String,withParameters Parameters:[String:Any]?,withAttachments Attachments:[Any]?,withAttachmentName:[String]?,UploadParameter:String?,httpMethod:HTTPMethod,ShowLoader:Bool,ShowTrueFalseValue:Bool,showretry:Bool? = true ,RetryMethod:(()->())?,URLisStatic:Bool? = false,completionHandler:@escaping CompletionHandler)
    {
        var url = ""
        if URLisStatic == false
        {
            url = "\(Url)\(ClientVersion)\(serviceName)"
        }
        else
        {
            url = serviceName
        }
        print(url)
        if let attachments = Attachments{
            if (NetworkReachabilityManager()?.isReachable)!{
                if ShowLoader
                {
                    KVNProgress.show()
                }
                print("internet")

                manager.upload(multipartFormData: { (multipart) in
                    for Attachment in attachments
                    {
                        let randome = arc4random()
//                        //let data = UIImageJPEGRepresentation(Attachment as! UIImage, 0.8)
                        let data = (Attachment as! UIImage).jpegData(compressionQuality: 0.75)
                        multipart.append(data!, withName: UploadParameter!, fileName: "randome\(randome).jpg", mimeType: "image/jpg")
                    }
                    if let params = Parameters{
                        print(Parameters!)
                        
                        for (key,value) in params{
                            multipart.append("\(value)".data(using: String.Encoding.utf8)!, withName: "\(key)")
                        }
                    }
                }, to: URL.init(string: url)!, encodingCompletion: { (Responce) in
                    switch Responce {
                    case .success(let upload, _, _):
                        upload.responseJSON { Responce in
                            if Responce.error == nil
                            {
                                
                                if ShowTrueFalseValue == false
                                {
                                    guard let responce = Responce.result.value else{return}
                                    guard let dic = responce as? [String:Any] else{return}
                                    
                                    if dic["status"] as? String ?? "" == "1"{
                                        if ShowLoader{
                                            KVNProgress.dismiss(completion: {
                                                guard let data = dic["data"] as? [[String:Any]] else {return}
                                                completionHandler(data)
                                            })
                                        }
                                        else
                                        {
                                            guard let data = dic["data"] as? [[String:Any]] else {return}
                                            completionHandler(data)
                                        }
                                    }
                                    else
                                    {
                                        if ShowLoader{
                                            KVNProgress.dismiss(completion: {
                                                guard let vc = self.app.window?.rootViewController else {return}
                                                RDAlertController.shared.simpleAlert(with: dic["message"] as? String ?? "", message: nil, presentOn: vc)
                                            })
                                        }
                                        else
                                        {
                                            guard let vc = self.app.window?.rootViewController else {return}
                                            RDAlertController.shared.simpleAlert(with: dic["message"] as? String ?? "", message: nil, presentOn: vc)
                                        }
                                    }
                                }
                                else if ShowTrueFalseValue == true
                                {
                                    if ShowLoader{
                                        KVNProgress.dismiss(completion: {
                                            guard let responce = Responce.result.value else{return}
                                            guard let dic = responce as? [String:Any] else{return}
                                            completionHandler([dic])
                                        })
                                    }
                                    else
                                    {
                                        guard let responce = Responce.result.value else{return}
                                        guard let dic = responce as? [String:Any] else{return}
                                        completionHandler([dic])
                                    }
                                }
                            }
                            else
                            {
                                if ShowLoader{
                                    KVNProgress.dismiss(completion: {
                                        if showretry != false{
                                          
                                            guard let vc = self.app.window?.rootViewController else {return}
                                            RDAlertController.shared.ServerError(presentOn: vc, retry: RetryMethod)
                                            
                                        }
                                        
                                    })
                                }
                                else
                                {
                                    if showretry != false{
                                        
                                        guard let vc = self.app.window?.rootViewController else {return}
                                        RDAlertController.shared.ServerError(presentOn: vc, retry: RetryMethod)
                                        
                                    }
                                }
                            }
                        }
                    case .failure(let _): //Remove (let _)
                        if ShowLoader{
                            KVNProgress.dismiss(completion: {
                                if showretry != false{
                                    
                                    guard let vc = self.app.window?.rootViewController else {return}
                                    RDAlertController.shared.ServerError(presentOn: vc, retry: RetryMethod)
                                    
                                }
                            })
                        }
                        else
                        {
                            if showretry != false{
                                
                                guard let vc = self.app.window?.rootViewController else {return}
                                RDAlertController.shared.ServerError(presentOn: vc, retry: RetryMethod)
                                
                            }
                        }
                    }
                    
                })
            }
            else
            {
                
                print("no internet")

                guard let vc = app.window?.rootViewController else {return}
                RDAlertController.shared.noInternet(presentOn: vc)
            }
        }
        else
        {
            if (NetworkReachabilityManager()?.isReachable)!{
                if ShowLoader
                {
                    KVNProgress.show()
                }
                print("internet")
                manager.request(URL.init(string: url)!, method: httpMethod, parameters: Parameters).responseJSON(completionHandler: { (Responce) in
                    
                    if Responce.error == nil
                    {
                        if ShowTrueFalseValue == false
                        {
                        guard let responce = Responce.result.value else{return}
                        guard let dic = responce as? [String:Any] else{return}
                        
                        if dic["status"] as? String ?? "" == "1"{
                            if ShowLoader{
                                KVNProgress.dismiss(completion: {
                                    guard let data = dic["data"] as? [[String:Any]] else {return}
                                    completionHandler(data)
                                })
                                }
                            else
                            {
                                guard let data = dic["data"] as? [[String:Any]] else {return}
                                completionHandler(data)
                            }
                        }
                        else
                        {
                            if ShowLoader{
                                KVNProgress.dismiss(completion: {
                                    guard let vc = self.app.window?.rootViewController else {return}
                                    RDAlertController.shared.simpleAlert(with: dic["message"] as? String ?? "", message: nil, presentOn: vc)
                                })
                            }
                            else
                            {
                                guard let vc = self.app.window?.rootViewController else {return}
                                RDAlertController.shared.simpleAlert(with: dic["message"] as? String ?? "", message: nil, presentOn: vc)
                            }
                        }
                        }
                        else if ShowTrueFalseValue == true
                        {
                            if ShowLoader{
                                KVNProgress.dismiss(completion: {
                                    guard let responce = Responce.result.value else{return}
                                    guard let dic = responce as? [String:Any] else{return}
                                    completionHandler([dic])
                                })
                            }
                            else
                            {
                                guard let responce = Responce.result.value else{return}
                                guard let dic = responce as? [String:Any] else{return}
                                completionHandler([dic])
                            }
                        }
                    }
                    else
                    {
                        if ShowLoader{
                            KVNProgress.dismiss(completion: {
                                if showretry != false{
                                    
                                    guard let vc = self.app.window?.rootViewController else {return}
                                    RDAlertController.shared.ServerError(presentOn: vc, retry: RetryMethod)
                                    
                                }
                            })
                        }
                        else
                        {
                            if showretry != false{
                                
                                guard let vc = self.app.window?.rootViewController else {return}
                                RDAlertController.shared.ServerError(presentOn: vc, retry: RetryMethod)
                                
                            }
                        }
                    }
                })
            }
            else
            {
                if showretry != false{
                    print("no internet")
                    
                    guard let vc = self.app.window?.rootViewController else {return}
                    RDAlertController.shared.serverChek(presentOn: vc, retry: RetryMethod)
                    
                    
                }
            }
        }
    }
}

