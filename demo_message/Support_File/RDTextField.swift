
//  RDTextField.swift
//  CLM
//
//  Created by DECODER on 20/08/18.
//  Copyright © 2018 DECODER. All rights reserved.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField

class RDTextField:SkyFloatingLabelTextField{
    
    @IBInspectable var leftImage:UIImage?
        {
        didSet{
            if let image = leftImage{
                self.leftViewMode = .always
                let imageView = UIImageView.init(image: image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate))
                imageView.tintColor = UIColor.black//ImageTintColor
                imageView.contentMode = .scaleAspectFit
                imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
                self.leftView = imageView
                self.layoutIfNeeded()
            }
        }
    }
    
    @IBInspectable var rightImage:UIImage?
        {
        didSet{
            if let image = rightImage{
                self.rightViewMode = .always
                let imageView = UIImageView.init(image: image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate))
                imageView.tintColor = UIColor.lightGray//ImageTintColor
                imageView.contentMode = .scaleAspectFit
                self.rightView = imageView
                self.layoutIfNeeded()
            }
        }
    }
    
    @IBInspectable var PlaceholderColor1:UIColor?
        {
        didSet{
            if let color = PlaceholderColor1 {
                if let Placeholdertext = self.placeholder
                {
                    self.attributedPlaceholder = NSAttributedString.init(string: Placeholdertext, attributes: [NSAttributedString.Key.foregroundColor : color])
                }
            }
        }
    }
    
    override var titleFormatter: ((String) -> String)
        {
        set{
            
        }
        get{
            return { $0 }
        }
        
    }
    
    //    @IBInspectable var ImageColor:UIColor = UIColor.white
    //    {
    //        didSet{
    //            self.rightView?.tintColor = ImageColor
    //        }
    //    }
    // var padding:CGFloat = 10
    var padding:CGFloat = 0
    var PlaceholderPadding:CGFloat = 55
    
    var ImageTintColor:UIColor = UIColor.white
    
    
    var imagePadding:CGFloat = 30
    var imagetopPadding:CGFloat = 5
    var ShowTitleLabel = true
    
    
    override func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        if ShowTitleLabel == false
        {
            return CGRect.init(x: 0, y: 0, width: 0, height: 0)
        }
        else
        {
            print(bounds)
            let rect = super.titleLabelRectForBounds(bounds, editing: editing)
            print(rect)
            return rect
        } 
    }
    //    override func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
    //        return CGRect.init(x: 0, y: 0, width: 0, height: 0)
    //    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.insetBy(dx: padding, dy: 0)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let rect = self.editingRect(forBounds: bounds)//super.placeholderRect(forBounds: bounds)
        //rect.origin.x = rect.origin.x + PlaceholderPadding
        return rect//rect.insetBy(dx: padding, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.insetBy(dx: padding, dy: 0)
    }
    
    //    override func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
    //        let rect = super.titleLabelRectForBounds(bounds, editing: editing)
    //        return rect.insetBy(dx: padding, dy: 0)
    //    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.y = rect.origin.y + imagetopPadding
        return rect//rect.insetBy(dx: imagePadding, dy: imagetopPadding)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.y = rect.origin.y + imagetopPadding
        return rect//rect.insetBy(dx: imagePadding, dy: imagetopPadding)
    }
    
}


