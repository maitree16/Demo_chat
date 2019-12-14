//
//  MessageData.swift
//  demo_message
//
//  Created by Maitree on 20/09/19.
//  Copyright © 2019 virtual height. All rights reserved.
//

import Foundation


class messageList : NSObject, NSCoding{
    
    var data : [messageData]!
    var errorMsg : String!
    var status : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        errorMsg = dictionary["error_msg"] as? String
        status = dictionary["status"] as? String
        data = [messageData]()
        if let dataArray = dictionary["data"] as? [[String:Any]]{
            for dic in dataArray{
                let value = messageData(fromDictionary: dic)
                data.append(value)
            }
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if errorMsg != nil{
            dictionary["error_msg"] = errorMsg
        }
        if status != nil{
            dictionary["status"] = status
        }
        if data != nil{
            var dictionaryElements = [[String:Any]]()
            for dataElement in data {
                dictionaryElements.append(dataElement.toDictionary())
            }
            dictionary["data"] = dictionaryElements
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        data = aDecoder.decodeObject(forKey: "data") as? [messageData]
        errorMsg = aDecoder.decodeObject(forKey: "error_msg") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if data != nil{
            aCoder.encode(data, forKey: "data")
        }
        if errorMsg != nil{
            aCoder.encode(errorMsg, forKey: "error_msg")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
    }
}
