//
//  MessageData.swift
//  demo_message
//
//  Created by Maitree on 20/09/19.
//  Copyright © 2019 virtual height. All rights reserved.
//

import Foundation


class messageData : NSObject, NSCoding{
    
    var createdDate : String!
    var filepath : String!
    var groupId : String!
    var id : String!
    var isView : String!
    var message : String!
    var msgtype : String!
    var receiverId : String!
    var receiverLastname : String!
    var receiverName : String!
    var receiverProfilePic : String!
    var senderId : String!
    var senderLastName : String!
    var senderProfilePic : String!
    var senderid : String!
    var sendername : String!
    var status : String!
    var timeFormat : String!
    var unreadMsg : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        createdDate = dictionary["created_date"] as? String
        filepath = dictionary["filepath"] as? String
        groupId = dictionary["group_id"] as? String
        id = dictionary["id"] as? String
        isView = dictionary["is_view"] as? String
        message = dictionary["message"] as? String
        msgtype = dictionary["msgtype"] as? String
        receiverId = dictionary["receiver_id"] as? String
        receiverLastname = dictionary["receiver_lastname"] as? String
        receiverName = dictionary["receiver_name"] as? String
        receiverProfilePic = dictionary["receiver_profile_pic"] as? String
        senderId = dictionary["sender_id"] as? String
        senderLastName = dictionary["sender_last_name"] as? String
        senderProfilePic = dictionary["sender_profile_pic"] as? String
        senderid = dictionary["senderid"] as? String
        sendername = dictionary["sendername"] as? String
        status = dictionary["status"] as? String
        timeFormat = dictionary["time_format"] as? String
        unreadMsg = dictionary["unread_msg"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if createdDate != nil{
            dictionary["created_date"] = createdDate
        }
        if filepath != nil{
            dictionary["filepath"] = filepath
        }
        if groupId != nil{
            dictionary["group_id"] = groupId
        }
        if id != nil{
            dictionary["id"] = id
        }
        if isView != nil{
            dictionary["is_view"] = isView
        }
        if message != nil{
            dictionary["message"] = message
        }
        if msgtype != nil{
            dictionary["msgtype"] = msgtype
        }
        if receiverId != nil{
            dictionary["receiver_id"] = receiverId
        }
        if receiverLastname != nil{
            dictionary["receiver_lastname"] = receiverLastname
        }
        if receiverName != nil{
            dictionary["receiver_name"] = receiverName
        }
        if receiverProfilePic != nil{
            dictionary["receiver_profile_pic"] = receiverProfilePic
        }
        if senderId != nil{
            dictionary["sender_id"] = senderId
        }
        if senderLastName != nil{
            dictionary["sender_last_name"] = senderLastName
        }
        if senderProfilePic != nil{
            dictionary["sender_profile_pic"] = senderProfilePic
        }
        if senderid != nil{
            dictionary["senderid"] = senderid
        }
        if sendername != nil{
            dictionary["sendername"] = sendername
        }
        if status != nil{
            dictionary["status"] = status
        }
        if timeFormat != nil{
            dictionary["time_format"] = timeFormat
        }
        if unreadMsg != nil{
            dictionary["unread_msg"] = unreadMsg
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        createdDate = aDecoder.decodeObject(forKey: "created_date") as? String
        filepath = aDecoder.decodeObject(forKey: "filepath") as? String
        groupId = aDecoder.decodeObject(forKey: "group_id") as? String
        id = aDecoder.decodeObject(forKey: "id") as? String
        isView = aDecoder.decodeObject(forKey: "is_view") as? String
        message = aDecoder.decodeObject(forKey: "message") as? String
        msgtype = aDecoder.decodeObject(forKey: "msgtype") as? String
        receiverId = aDecoder.decodeObject(forKey: "receiver_id") as? String
        receiverLastname = aDecoder.decodeObject(forKey: "receiver_lastname") as? String
        receiverName = aDecoder.decodeObject(forKey: "receiver_name") as? String
        receiverProfilePic = aDecoder.decodeObject(forKey: "receiver_profile_pic") as? String
        senderId = aDecoder.decodeObject(forKey: "sender_id") as? String
        senderLastName = aDecoder.decodeObject(forKey: "sender_last_name") as? String
        senderProfilePic = aDecoder.decodeObject(forKey: "sender_profile_pic") as? String
        senderid = aDecoder.decodeObject(forKey: "senderid") as? String
        sendername = aDecoder.decodeObject(forKey: "sendername") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String
        timeFormat = aDecoder.decodeObject(forKey: "time_format") as? String
        unreadMsg = aDecoder.decodeObject(forKey: "unread_msg") as? String
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if createdDate != nil{
            aCoder.encode(createdDate, forKey: "created_date")
        }
        if filepath != nil{
            aCoder.encode(filepath, forKey: "filepath")
        }
        if groupId != nil{
            aCoder.encode(groupId, forKey: "group_id")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if isView != nil{
            aCoder.encode(isView, forKey: "is_view")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if msgtype != nil{
            aCoder.encode(msgtype, forKey: "msgtype")
        }
        if receiverId != nil{
            aCoder.encode(receiverId, forKey: "receiver_id")
        }
        if receiverLastname != nil{
            aCoder.encode(receiverLastname, forKey: "receiver_lastname")
        }
        if receiverName != nil{
            aCoder.encode(receiverName, forKey: "receiver_name")
        }
        if receiverProfilePic != nil{
            aCoder.encode(receiverProfilePic, forKey: "receiver_profile_pic")
        }
        if senderId != nil{
            aCoder.encode(senderId, forKey: "sender_id")
        }
        if senderLastName != nil{
            aCoder.encode(senderLastName, forKey: "sender_last_name")
        }
        if senderProfilePic != nil{
            aCoder.encode(senderProfilePic, forKey: "sender_profile_pic")
        }
        if senderid != nil{
            aCoder.encode(senderid, forKey: "senderid")
        }
        if sendername != nil{
            aCoder.encode(sendername, forKey: "sendername")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if timeFormat != nil{
            aCoder.encode(timeFormat, forKey: "time_format")
        }
        if unreadMsg != nil{
            aCoder.encode(unreadMsg, forKey: "unread_msg")
        }
    }
}
