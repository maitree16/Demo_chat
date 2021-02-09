//
//  GlobalViewShadow.swift
//  Carring
//
//  Created by mackbook on 7/5/16.
//  Copyright © 2017 virtualheight. All rights reserved.
//

import UIKit

//Can  this be final class?
class GlobalViewShadow: NSObject {
    
    //Can  this be final class?
    class func ShadowWithoutBorder(_ shadow: UIView,color: UIColor)
    {
        shadow.layer.shadowRadius = 3
        shadow.layer.shadowColor = color.cgColor
        shadow.layer.shadowOffset = CGSize.zero
        shadow.layer.shadowOpacity = 1.0//0.7
    }
    
    //Can  this be final class?
    class func ShadowWithBorder(_ BorderShadow: UIView)
    {
        
//        BorderShadow.layer.cornerRadius = 5
//        BorderShadow.layer.borderWidth = 1
//        BorderShadow.layer.borderColor =  UIColor.black.cgColor
        BorderShadow.layer.shadowRadius = 5
        BorderShadow.layer.shadowColor = UIColor.darkGray.cgColor
        BorderShadow.layer.shadowOffset = CGSize(width: 1, height: 1)
        BorderShadow.layer.shadowOpacity = 0.5

    }
    
    
    //Can  this be final class?
    class func OnlyShadow(_ shadow: UIView)
    {
        shadow.layer.shadowColor = UIColor.darkGray.cgColor
        shadow.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        shadow.layer.shadowOpacity = 0.2

    }

}
