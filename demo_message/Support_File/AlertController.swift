//
//  AlertController.swift
//  Vibrant
//
//  Created by Admin on 23/10/18.
//  Copyright © 2018 VH. All rights reserved.
//

import UIKit

extension String {
    ///tableName is FreeNow,
    ///missing string will be displayed when no value exists.
    func localizedString(_ comment: String = "") -> String {
        NSLocalizedString(
            self,
            tableName: "Localizable",
            value: "missing string: \(self)",
            comment: comment
        )
    }
}

//Can  this be final class?
class RDAlertController
{
    //Can  this be final class?
    //Avoid singltons. If you want to use singleton do it like this
//    class API
//    {
//        static let shared = API()
//
//        private init()
//        {
//            // Set up API instance
//        }
//    }
    class var shared:RDAlertController
    {
        struct sharedController
        {
            static var controller = RDAlertController()
        }
        return sharedController.controller
    }
    
    func simpleAlert(with title:String?,message:String?,presentOn vc:UIViewController)
    {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "okay.key".localizedString(), style: .default, handler: nil) //Use localisation
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
    
    func noInternet(presentOn vc:UIViewController)
    {
        let alert = UIAlertController.init(title: "No Internet", message: nil, preferredStyle: .alert)
        let Settingsaction = UIAlertAction.init(title: "Settings", style: .default) { (action) in
            if UIApplication.shared.canOpenURL(URL.init(string: UIApplication.openSettingsURLString)!)
            {
                UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }
        }
        let close = UIAlertAction.init(title: "Close", style: .cancel, handler: nil)
        alert.addAction(Settingsaction)
        alert.addAction(close)
        vc.present(alert, animated: true, completion: nil)
    }
    func ServerError(presentOn vc:UIViewController,retry:(()->())?)
    {
        let alert = UIAlertController.init(title: "OOPS! server error", message: nil, preferredStyle: .alert)
        if let ret = retry
        {
            let retryaction = UIAlertAction.init(title: "Retry", style: .default) { (action) in
                ret()
            }
            alert.addAction(retryaction)
        }
    
        let close = UIAlertAction.init(title: "Close", style: .cancel, handler: nil)
        alert.addAction(close)
        vc.present(alert, animated: true, completion: nil)
    }
    
    func serverChek(presentOn vc: UIViewController, retry: (()->())?)
   {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller  = storyboard.instantiateViewController(withIdentifier: "NoInternetVC")as! NoInternetVC
        controller.view.frame = vc.view.bounds
        controller.TryAgain(presentOn: vc, retry: retry)
        vc.present(controller, animated: true, completion: nil)

//       let alert = UIAlertController.init(title: "retryy", message: nil, preferredStyle: .alert)
//        if let ret = retry
//        {
//            let retryaction = UIAlertAction.init(title: "Retry", style: .default) { (action) in
//                ret()
//            }
//            alert.addAction(retryaction)
//        }
//
//        let close = UIAlertAction.init(title: "Close", style: .cancel, handler: nil)
//        alert.addAction(close)
//        var height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: vc.view.frame.height * 0.80)
//
//       var width:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 200)
//    print(vc.view.frame.width)
//
//        alert.view.addConstraint(height)
//        alert.view.addConstraint(width)
//
//
//        vc.present(alert, animated: true, completion: nil)
    
        
    }
}
