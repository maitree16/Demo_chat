//
//  MessageVC.swift
//  Meal_Do
//
//  Created by Decoder on 20/06/19.
//  Copyright © 2019 Dhaval. All rights reserved.
//

import UIKit
import SDWebImage
import Reachability

struct Test {
    
    let message:String
    let msgtype: String
    let sender_id:String
    let receiver_name:String
    let time_format: String
    let sendername:String
    let receiver_id:String
}

class MessageVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var lblNoChat: UILabel!
    @IBOutlet weak var lnlNoMsg: UILabel!
    @IBOutlet weak var MessageTableView: UITableView!
    var fromMenu = String()
    var messagelist = [[String:Any]]()
    var reachability: Reachability?
    let dta = [Test.init(message: "", msgtype: "location", sender_id: "34", receiver_name: "xyz", time_format: "1min ago", sendername: "def", receiver_id: "2"),
               Test.init(message: "", msgtype: "image", sender_id: "34", receiver_name: "mno", time_format: "2hr ago", sendername: "def", receiver_id: "20"),
               Test.init(message: "test", msgtype: "message", sender_id: "34", receiver_name: "ghj", time_format: "3hr ago", sendername: "def", receiver_id: "29")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lnlNoMsg.isHidden = true
        self.lblNoChat.isHidden = true
        MessageTableView.rowHeight = 110
        MessageTableView.estimatedRowHeight = UITableView.automaticDimension
        self.MessageTableView.reloadData()

    }
   
    override func viewWillAppear(_ animated: Bool) {
        //Api call Here
      //  apiGetMessage()
        let nib = UINib(nibName: "Message", bundle: nil)
        MessageTableView.register(nib, forCellReuseIdentifier: "Cell")
        MessageTableView.tableFooterView = UIView()
    }
  
    //Tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dta.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Message
        let userid = "34"
        if  userid == dta[indexPath.row].sender_id{
            if dta[indexPath.row].msgtype == "message"{
                cell.lblMessage.text =  dta[indexPath.row].message
                cell.iconImage.isHidden = true
                cell.lblMsgType.isHidden = true
                cell.lblMessage.isHidden = false
                cell.lblMessage.text =  dta[indexPath.row].message
            }else if dta[indexPath.row].msgtype  ==  "image"{
                cell.lblMessage.isHidden = true
                cell.iconImage.isHidden = false
                cell.lblMsgType.isHidden = false
                cell.iconImage.image = #imageLiteral(resourceName: "gallery (1)")
                cell.lblMsgType.text = "Photo"
            }else if dta[indexPath.row].msgtype  ==  "location"{
                cell.lblMessage.isHidden = true
                cell.iconImage.isHidden = false
                cell.lblMsgType.isHidden = false
                cell.iconImage.image = #imageLiteral(resourceName: "locationFeed")
                cell.lblMsgType.text = "Location"
            }else{
            }
            
            cell.lblname.text = dta[indexPath.row].receiver_name
            cell.lblday.text = dta[indexPath.row].time_format
            cell.imageProfile.image = #imageLiteral(resourceName: "user (3)")
            
        }else{
            if dta[indexPath.row].msgtype  == "message"{
                cell.lblMessage.text =  dta[indexPath.row].message
                cell.iconImage.isHidden = true
                cell.lblMsgType.isHidden = true
                cell.lblMessage.text =  dta[indexPath.row].message
                
            }else if dta[indexPath.row].msgtype  ==  "image"{
                cell.lblMessage.isHidden = true
                cell.iconImage.image = #imageLiteral(resourceName: "gallery (1)")
                cell.lblMsgType.text = "Photo"
            }else if dta[indexPath.row].msgtype  ==  "location"{
                cell.lblMessage.isHidden = true
                cell.iconImage.image = #imageLiteral(resourceName: "locationFeed")
                cell.lblMsgType.text = "Location"
            }else{
            }
            cell.lblname.text = dta[indexPath.row].sendername
            cell.lblday.text = dta[indexPath.row].time_format
            cell.imageProfile.image = #imageLiteral(resourceName: "user (3)")
        }
        cell.imageProfile.layer.cornerRadius = cell.imageProfile.frame.size.height / 2
        cell.imageProfile.clipsToBounds = true
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userid = "34"
        let vc = storyboard?.instantiateViewController(withIdentifier: "PersonalChatVC") as? PersonalChatVC
        if  userid == dta[indexPath.row].sender_id{
            vc!.receiverId = dta[indexPath.row].receiver_id
            vc!.name = dta[indexPath.row].receiver_name
        }else{
            vc!.receiverId = dta[indexPath.row].sender_id
            vc!.name = dta[indexPath.row].sendername
        }
        
        
        
        vc!.hidesBottomBarWhenPushed = true
        self.navigationController?.show(vc!, sender: nil)
    }
    
    //MARK:-  api call
    func apiGetMessage(){
        let parameter : [String:Any] = [:]

        let messageList = ""
        
        ServiceManager.shared.MakeApiCall(ForServiceName: messageList, withParameters: parameter, withAttachments: nil, withAttachmentName: nil, UploadParameter: nil, httpMethod: .get, ShowLoader: true, ShowTrueFalseValue: true, RetryMethod: {
            self.apiGetMessage()
        }) { (responce) in

            print(responce!)
            let status = responce?[0]["status"] as? String ?? ""
            let message = responce?[0]["error_msg"] as? String ?? ""

            if status == "1"{
                self.MessageTableView.isHidden = false
                self.lnlNoMsg.isHidden = true
                self.lblNoChat.isHidden = true
                self.messagelist = responce?[0]["data"] as? [[String:Any]] ?? [[:]]
                self.MessageTableView.reloadData()
            }else{
                self.MessageTableView.isHidden = true
                self.lnlNoMsg.isHidden = false
                self.lblNoChat.isHidden = false
            }
        }
    }
}
