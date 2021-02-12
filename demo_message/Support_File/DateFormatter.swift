
//
//  DateFormatter.swift
//  TutorArround
//
//  Created by Admin on 05/12/18.
//  Copyright © 2018 VirtualHeight IT services PVT LTD. All rights reserved.
//

import Foundation

extension Date {

   static func convert(date:String, toFormatter:String, fromFormatter:String) -> String {
        
        let formatter = DateFormatter() //Dont use capitalisation
        formatter.dateFormat = toFormatter
        
        guard let toDate:Date = formatter.date(from: date) else {
            return ""
        } // guard on mutiple lines
        
        formatter.dateFormat = fromFormatter
        
        let convertDate = formatter.string(from: toDate)
        
        return convertDate
        
    }
}
