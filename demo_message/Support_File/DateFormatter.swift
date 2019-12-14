
//
//  DateFormatter.swift
//  TutorArround
//
//  Created by Admin on 05/12/18.
//  Copyright © 2018 VirtualHeight IT services PVT LTD. All rights reserved.
//

import Foundation

extension Date{
    
   static func Convert(Date:String,ToFormatter:String,FromFormatter:String) -> String {
        
        let Formatter = DateFormatter()
        Formatter.dateFormat = ToFormatter
        
        guard let ToDate:Date = Formatter.date(from: Date) else {return ""}
        
        Formatter.dateFormat = FromFormatter
        
        let ConvertDate = Formatter.string(from: ToDate)
        
        return ConvertDate
        
    }
}
