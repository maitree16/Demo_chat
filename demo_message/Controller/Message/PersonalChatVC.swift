//
//  PersonalChatVC.swift
//  Meal_Do
//
//  Created by Dipak Kasodariya on 01/07/19.
//  Copyright © 2019 Dhaval. All rights reserved.
//

import UIKit
import CoreLocation
import MobileCoreServices
import GoogleMaps
import GooglePlaces
import OpalImagePicker
import Photos

enum MessageTypeEnum: String {
    case image
    case message
    case location
}

struct TestChat {
    let message:String
    let msgtype: String
    var useEnumForMsgType: MessageTypeEnum {
        MessageTypeEnum(rawValue: msgtype) ?? .message
    }
    let sender_id:String
    let receiver_name:String
    let time_format: String
    let sendername:String
    let receiver_id:String
    let filepath:String
    
    var userIdEqualsMagicNumber34: Bool {
        sender_id == "34"
    }
}

class PersonalChatVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,CurrentLocationDelegate {
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var msgTxtField: UITextView!
    
    var messageData = [[String:Any]]()
    var userid : String?
    var receiverId : String?
    var messageHeader = [[String:Any]]()
    var gameTimer: Timer!
    var last_msg_id : String?
    var dte_time : String?
    var name = String()
    var locationCoordinate = CLLocationCoordinate2D()
    var messageType = ""
    var message = ""
    var imageUpload = UIImage()
    
 
    var msgDta = [TestChat.init(message: "locationNAme", msgtype: "location", sender_id: "34", receiver_name: "ghj", time_format: "1min ago", sendername: "def", receiver_id: "29",filepath : "23.022505,72.571365"),
               TestChat.init(message: "", msgtype: "image", sender_id: "34", receiver_name: "ghj", time_format: "1min ago", sendername: "def", receiver_id: "29",filepath : ""),
               TestChat.init(message: "test1", msgtype: "message", sender_id: "34", receiver_name: "ghj", time_format: "1min ago", sendername: "def", receiver_id: "29",filepath : ""),
               TestChat.init(message: "locationNAme", msgtype: "location", sender_id: "34", receiver_name: "ghj", time_format: "1min ago", sendername: "def", receiver_id: "29",filepath : "23.022505,72.571365"),
               TestChat.init(message: "test2", msgtype: "message", sender_id: "34", receiver_name: "ghj", time_format: "1min ago", sendername: "def", receiver_id: "29",filepath : ""),
               TestChat.init(message: "test3", msgtype: "message", sender_id: "29", receiver_name: "ghj", time_format: "1min ago", sendername: "def", receiver_id: "34",filepath : "")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // apiGetMessageList()
         gameTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        
        msgTxtField.text = "Write Your Message here.."
        msgTxtField.textColor = UIColor.darkGray
        msgTxtField.delegate = self
        
        chatTableView.rowHeight = UITableView.automaticDimension
        chatTableView.estimatedRowHeight = 200
        
        let nib = UINib(nibName: "ChatImage", bundle: nil)
        chatTableView.register(nib, forCellReuseIdentifier: "cellImage")
        
        chatTableView.tableFooterView = UIView()
        
        messageType = "message"
        msgTxtField.layer.cornerRadius = 20
        msgTxtField.clipsToBounds = true
        
        let tapGestureReconizer = UITapGestureRecognizer(target: self, action: #selector(tapCommnt(sender:)) )
        tapGestureReconizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureReconizer)

        
        // Do any additional setup after loading the view.
    }
    
    @objc func tapCommnt(sender: UITapGestureRecognizer) {
        view.endEditing(true)
        // or use
        msgTxtField.resignFirstResponder()
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if msgTxtField.textColor == UIColor.darkGray {
            msgTxtField.text = nil
            msgTxtField.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        message =  msgTxtField.text ?? "" .trimmingCharacters(in: .whitespaces)

        if msgTxtField.text.isEmpty {
            msgTxtField.text = "Write Your Message here.."
            msgTxtField.textColor = UIColor.darkGray
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = name
        self.navigationController?.isNavigationBarHidden = false

        
    }
   
    @objc func runTimedCode(){
       // apiGetMessageList()
    }

    override func viewWillDisappear(_ animated: Bool) {
        gameTimer.invalidate()
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if msgDta.count == 0{
        }else{
           // EmptyMessage(message: "", viewController: self, tblView: chatTableView, view: view)
            return msgDta.count
        }
        return 0
    }

    //Please simply the metthid. Pass message to ChatTableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = chatTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ChatTableViewCell else {
            return UITableViewCell()
        }
        
        guard let message = msgDta[safe: indexPath.row] else {
            return UITableViewCell()
        }
        let userid = "34" //Why 34?
        cell.selectionStyle = .none
        let cellImage = tableView.dequeueReusableCell(withIdentifier: StringConstants.cellImage.rawValue) as! ChatImageTableViewCell //Cell image not being used
  
        if message.userIdEqualsMagicNumber34 {
            
            switch message.useEnumForMsgType {

            case .location:
                cell.sender_stack_con.constant = 30
                cell.img_sender_con.constant = 150
                cell.img_reciver_con.constant = 150
                cell.reciver_stact_con.constant = 30
                
                let lat = msgDta[indexPath.row].filepath
                let location = lat.split(separator: ",")
                
                let url = getLocationStringUrl(coordinate: CLLocationCoordinate2D.init(latitude: Double(location[0]) ?? 0.0, longitude: Double(location[1]) ?? 0.0))
                
                print(url)
                
                cell.receiverView.isHidden = true
                cell.senderView.isHidden = true
                cell.senderStackView.isHidden = true
                cell.receiverStackView.isHidden = false
                cell.LocationName.isHidden = false
                cell.LocationName.text = msgDta[indexPath.row].message
                cell.senderSendImge.isHidden = true
                cell.ReceiverGetImage.isHidden = false
                cell.ReceiverImage.isHidden = false
                cell.senderImage.isHidden = true
                cell.lblReceiverMsg.isHidden = true
                cell.ReceiverImage.image = #imageLiteral(resourceName: "user (3)")
                
                cell.receivertime.text = msgDta[indexPath.row].time_format
               
                cell.ReceiverGetImage.sd_setImage(with: URL(string: url) , placeholderImage: #imageLiteral(resourceName: "locationFeed"))
                return cell
            case .image:
                cell.sender_stack_con.constant = 30
                cell.img_sender_con.constant = 150
                cell.img_reciver_con.constant = 150
                cell.reciver_stact_con.constant = 30
                
                cell.receiverView.isHidden = true
                cell.senderView.isHidden = true
                cell.senderSendImge.isHidden = true
                cell.ReceiverGetImage.isHidden = false
               // cell.lblsenderMsg.isHidden = true
               // cell.lblReceiverMsg.isHidden = true
                cell.ReceiverImage.isHidden = false
                cell.senderImage.isHidden = true
                cell.lblReceiverMsg.isHidden = true
                cell.ReceiverImage.image = #imageLiteral(resourceName: "user (3)")
               // cell.senderLblTime.isHidden = false
               // cell.receiverLblTime.isHidden = true
                cell.senderStackView.isHidden = true
                cell.receiverStackView.isHidden = false
                cell.LocationName.isHidden = true
              
                cell.senderLblTime.backgroundColor = UIColor.white

                cell.receivertime.text = msgDta[indexPath.row].time_format
                let formatter = DateFormatter.init()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                //formatter.locale = Locale.init(identifier: "en_US_POSIX")
                cell.ReceiverGetImage.image = #imageLiteral(resourceName: "user (3)")
                return cell
               // return cellImage
            case .message:
                cell.sender_stack_con.constant = 0
                cell.img_sender_con.constant = 0
                cell.img_reciver_con.constant = 0
                cell.reciver_stact_con.constant = 0
                
                cell.receiverView.isHidden = false
                cell.senderView.isHidden = false
                cell.senderStackView.isHidden = true
                cell.receiverStackView.isHidden = true
                cell.senderSendImge.isHidden = true
                cell.ReceiverGetImage.isHidden = true
                cell.lblsenderMsg.isHidden = true
                cell.lblReceiverMsg.isHidden = false
                cell.ReceiverImage.isHidden = false
                cell.senderImage.isHidden = true
                cell.lblReceiverMsg.text = msgDta[indexPath.row].message
                cell.ReceiverImage.image = #imageLiteral(resourceName: "user (3)")
                cell.senderLblTime.isHidden = false
                cell.receiverLblTime.isHidden = true
                cell.receiverView.isHidden = false
                cell.senderView.isHidden = true
                cell.senderLblTime.backgroundColor = UIColor.clear

                cell.senderLblTime.text = msgDta[indexPath.row].time_format
                let formatter = DateFormatter.init()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                //formatter.locale = Locale.init(identifier: "en_US_POSIX")
                
                return cell
            }
            

            
        }else{
            
            switch message.useEnumForMsgType {
            case .location:
                cell.sender_stack_con.constant = 30
                cell.img_sender_con.constant = 150
                cell.img_reciver_con.constant = 150
                cell.reciver_stact_con.constant = 30
                
                let lat = msgDta[indexPath.row].filepath
                let location = lat.split(separator: ",")
                
                let url = getLocationStringUrl(coordinate: CLLocationCoordinate2D.init(latitude: Double(location[0]) ?? 0.0, longitude: Double(location[1]) ?? 0.0))
                
                print(url)
            
                
                cell.senderStackView.isHidden = false
                cell.receiverStackView.isHidden = true
                cell.receiverView.isHidden = true
                cell.senderView.isHidden = true
                cell.senderLocationName.text = msgDta[indexPath.row].message
                cell.senderLocationName.isHidden = false
                //cell.senderWidth.constant = 200
                //cell.senderHeight.constant = 150
                cell.senderSendImge.isHidden = false
                cell.ReceiverGetImage.isHidden = true
            
                cell.senderLblTime.isHidden = true
                cell.receiverLblTime.isHidden = false
                cell.lblsenderMsg.isHidden = true
                cell.lblReceiverMsg.isHidden = true
                cell.ReceiverImage.isHidden = true
                cell.senderImage.isHidden = false
                cell.lblsenderMsg.frame.inset(by: UIEdgeInsets.init(top: 5, left: 15, bottom: 5, right: 15))
                cell.senderImage.image = #imageLiteral(resourceName: "user (3)")
                
                cell.senderSendImge.sd_setImage(with: URL(string: url) , placeholderImage: #imageLiteral(resourceName: "locationFeed"))
                // let date = self.messageData[indexPath.row]["created_date"] as? String ?? ""
                let formatter = DateFormatter.init()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                // formatter.locale = Locale.init(identifier: "en_US_POSIX")
                cell.sendertime.text = msgDta[indexPath.row].time_format
                cell.receiverLblTime.backgroundColor = UIColor.white
                
                return cell // 
            case .image:
                cell.sender_stack_con.constant = 30
                cell.img_sender_con.constant = 150
                cell.img_reciver_con.constant = 150
                cell.reciver_stact_con.constant = 30
                cellImage.senderProfile.isHidden = false
                cellImage.senderSendImage.isHidden = false

                cellImage.receiverSendImage.isHidden = true
                cellImage.ReceiverProfile.isHidden = true

                cellImage.senderSendImage.image = #imageLiteral(resourceName: "user (3)")
                cellImage.senderProfile.image = #imageLiteral(resourceName: "user (3)")
               // return cellImage
                cell.senderStackView.isHidden = false
                cell.receiverStackView.isHidden = true
                cell.receiverView.isHidden = true
                cell.senderView.isHidden = true
                //cell.senderWidth.constant = 200
               // cell.senderHeight.constant = 150
                cell.senderSendImge.isHidden = false
                cell.ReceiverGetImage.isHidden = true
                
                cell.senderLocationName.isHidden = true
            
                cell.senderLblTime.isHidden = true
                cell.receiverLblTime.isHidden = false
                cell.lblsenderMsg.isHidden = true
                cell.lblReceiverMsg.isHidden = true
                cell.ReceiverImage.isHidden = true
                cell.senderImage.isHidden = false
                cell.lblsenderMsg.text = msgDta[indexPath.row].message
                cell.lblsenderMsg.frame.inset(by: UIEdgeInsets.init(top: 5, left: 15, bottom: 5, right: 15))
                cell.senderImage.image = #imageLiteral(resourceName: "user (3)")
                
                cell.senderSendImge.image = #imageLiteral(resourceName: "user (3)")
                // let date = self.messageData[indexPath.row]["created_date"] as? String ?? ""
                let formatter = DateFormatter.init()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                // formatter.locale = Locale.init(identifier: "en_US_POSIX")
                
                cell.sendertime.backgroundColor = UIColor.white

                cell.sendertime.text = msgDta[indexPath.row].time_format
                
              
                return cell
            case .message:
                cell.sender_stack_con.constant = 0
                cell.img_sender_con.constant = 0
                cell.img_reciver_con.constant = 0
                cell.reciver_stact_con.constant = 0
                
                
                cell.senderStackView.isHidden = true
                cell.receiverStackView.isHidden = true
                cell.receiverView.isHidden = false
                cell.senderView.isHidden = false
               // cell.senderWidth.constant = 0
               // cell.senderHeight.constant = 0
                cell.senderSendImge.isHidden = true
                cell.ReceiverGetImage.isHidden = true
                cell.senderSendImge.isHidden = true
                cell.ReceiverGetImage.isHidden = true
                cell.receiverView.isHidden = true
                cell.senderView.isHidden = false
                cell.senderLblTime.isHidden = true
                cell.receiverLblTime.isHidden = false
                cell.lblsenderMsg.isHidden = false
                cell.lblReceiverMsg.isHidden = true
                cell.ReceiverImage.isHidden = true
                cell.senderImage.isHidden = false
                cell.lblsenderMsg.text = msgDta[indexPath.row].message
                cell.lblsenderMsg.frame.inset(by: UIEdgeInsets.init(top: 5, left: 15, bottom: 5, right: 15))
                cell.senderImage.image = #imageLiteral(resourceName: "user (3)")
                // let date = self.messageData[indexPath.row]["created_date"] as? String ?? ""
                let formatter = DateFormatter.init()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                // formatter.locale = Locale.init(identifier: "en_US_POSIX")
                
              
                cell.receiverLblTime.backgroundColor = UIColor.clear

                cell.receiverLblTime.text = msgDta[indexPath.row].time_format
                
               
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if userid != msgDta[indexPath.row].sender_id{
            if msgDta[indexPath.row].msgtype == "location"{
                
                let lat = msgDta[indexPath.row].filepath
                let location = lat.split(separator: ",")
                
                let url = getLocationStringUrl(coordinate: CLLocationCoordinate2D.init(latitude: Double(location[0]) ?? 0.0, longitude: Double(location[1]) ?? 0.0))
                
                print(url)
                
                if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
                    UIApplication.shared.open((NSURL(string:
                        "comgooglemaps://?saddr=&daddr=\(Double(location[0]) ?? 0.0),\(Double(location[1]) ?? 0.0)&directionsmode=driving")! as URL), options: [:], completionHandler: nil)
                } else {
                    NSLog("Can't use comgooglemaps://");
                }
                
                
            }
        }
        else{
            if msgDta[indexPath.row].msgtype == "location"{
                let lat = self.msgDta[indexPath.row].filepath
                    let location = lat.split(separator: ",")
                    
                let url = self.getLocationStringUrl(coordinate: CLLocationCoordinate2D.init(latitude: Double(location[0]) ?? 0.0, longitude: Double(location[1]) ?? 0.0))
                    
                    print(url)
                    
                    if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
                        UIApplication.shared.open((NSURL(string:
                            "comgooglemaps://?saddr=&daddr=\(Double(location[0]) ?? 0.0),\(Double(location[1]) ?? 0.0)&directionsmode=driving")! as URL), options: [:], completionHandler: nil)
                    } else {
                        NSLog("Can't use comgooglemaps://");
                    }
                    
                    
                }
            }
        }
        
        

    @IBAction func btnSend(_ sender: Any) {
        if msgTxtField.text?.isEmpty == true{
            UIAlertController().Simplealert(withTitle: "message can't be empty", Message: "", presentOn: self)
        }
        else if msgTxtField.text!.trimmingCharacters(in: .whitespaces).isEmpty {
            // string contains non-whitespace characters
            UIAlertController().Simplealert(withTitle: "message can't be empty", Message: "", presentOn: self)
        }else if msgTxtField.text == "Write Your Message here.."{
            UIAlertController().Simplealert(withTitle: "message can't be empty", Message: "", presentOn: self)
        }
        else{
           let sendData =  TestChat.init(message: msgTxtField.text, msgtype: "message", sender_id: "34", receiver_name: "ghj", time_format: "1min ago", sendername: "def", receiver_id: "29",filepath : "")
            self.msgTxtField.text = ""
            msgDta.append(sendData)
            chatTableView.reloadData()
            
            //api for send message
           // apiSendMessage()
        }
    }
    
    @IBAction func btnAttechment(_ sender: Any) {
        let alertMessage = UIAlertController(title: "Please select action", message: "", preferredStyle: .actionSheet)
        
        let image = #imageLiteral(resourceName: "gallery (1)")
        let action = UIAlertAction.init(title: "Gallery", style: .default) { (alert) in
//            let picker = UIImagePickerController.init()
//            picker.allowsEditing = true
//            picker.delegate = self
//            picker.sourceType = .photoLibrary
//            self.present(picker, animated: true, completion: nil)
            self.openGallery()
           
        }
        action.setValue(image, forKey: "image")
      
        let image1 = #imageLiteral(resourceName: "locationFeed")
        let action2 = UIAlertAction.init(title: "Location", style: .default) { (alert) in
            self.gameTimer.invalidate()
            
             self.messageType = "location"
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LocationMapVC") as! LocationMapVC
            vc.providesPresentationContextTransitionStyle = true
            vc.definesPresentationContext = true
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
           // vc.fromImage = "false"
            vc.delegate = self
          //  vc.feedid = singleFeedArray[0]["id"] as? String ?? ""
            self.present(vc, animated: true, completion: nil)
            
            
//           // https://maps.googleapis.com/maps/api/staticmap?center=data&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C23.0263644,72.5261789&key=AIzaSyD6LrO2qEdIViudfFpxIg60EYIVniCj4E0
//
//
        }
        action2.setValue(image1, forKey: "image")
        
        var cancel = UIAlertAction.init(title: "Cancel", style: .destructive) { (cancel) in
             alertMessage.dismiss(animated: true, completion: nil)
        }
        
        alertMessage.addAction(action)
        alertMessage.addAction(action2)
        alertMessage.addAction(cancel)
        self.present(alertMessage, animated: true, completion: nil)
    }
    
    //MARK:- method for open gallery
    func openGallery()
    {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            //Show error to user?
            return
        }
        let imagePicker = OpalImagePickerController()
        imagePicker.maximumSelectionsAllowed = 1
        
        presentOpalImagePickerController(imagePicker, animated: true, select: { (info) in
            //Save Images, update UI
            print(info)
          
            imagePicker.allowedMediaTypes = Set([PHAssetMediaType.image])


            //Saved images in array
            for i in 0..<info.count{
                let image = self.getUIImage(asset: info[i])
                print(image)
                
                //  self.pickedIamges.append(image)
                //  vehicleImages.append(image)
                //vehicleImages = self.pickedIamges
            }
            
            // vehicleRandomName = [self.randomString(length: 5)];
            //  self.collectionViewImages.reloadData()
            //Dismiss Controller
            imagePicker.dismiss(animated: true, completion: nil)
        }, cancel: {
            //Cancel action?
        })
    }
    //MARK:- GET IMAGES FROM ASSETS
    func getUIImage(asset: PHAsset) -> UIImage{
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true
        options.isSynchronous = false
        var thumbnail = UIImage()
        manager.requestImageData(for: asset, options: options) { (result, string, orientation, info) -> Void in
            print(result)
            print(string , "jg")
            print(orientation)
            let img = UIImage(data: result!)
            
            print(img)
            self.imageUpload = img ?? #imageLiteral(resourceName: "mealdo_icon_withoutbackground")
           self.message = ""
            self.messageType = "image"
            self.apiSendMessageWithImage()
           // self.messageData.append(["imageProfile" : img!])

           // self.event_images.append(img!)
            //print(self.event_images)
            
            thumbnail = img!
            
            self.chatTableView.reloadData()
           // self.photoCollectionView.reloadData()
            //self.imageViewProfile.image = img
        }
        return thumbnail
    }
    
    func getLocation(coordinate: CLLocationCoordinate2D, name : String) {
       
        locationCoordinate = coordinate
        message = name
       // apiSendMessage()
      
    }
    
    
    
    func getLocationStringUrl (coordinate: CLLocationCoordinate2D) -> String{
        
        print(coordinate)
         let staticMapUrl: String = "http://maps.googleapis.com/maps/api/staticmap?center=\(coordinate.latitude),\(coordinate.longitude)&zoom=18&markers=color:red|label:C|\(coordinate.latitude),\(coordinate.longitude)&size=300x300&sensor=false&key=AIzaSyB2Xt4rB_KQMkZDUQ8t2bRKks3_2a8U6jk"
        
        print(staticMapUrl)
        
        if let urlStr : NSString = (staticMapUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! as NSString){
            //self.messageData.append(["imageProfile" : urlStr])
            return urlStr as String
            //self.chatTableView.reloadData()
        }
        
    }
    
    //APi send msg list
    func apiSendMessage(){

        var latlng = [String]()
        if locationCoordinate.latitude != 0{
            latlng.append("\(locationCoordinate.latitude)")
            latlng.append("\(locationCoordinate.longitude)")
            
        }
        
        let parameter : [String : Any] = [:]
            

        print(parameter)
        let sendMessage = ""
        ServiceManager.shared.MakeApiCall(ForServiceName: sendMessage, withParameters: parameter, withAttachments: nil, withAttachmentName: nil, UploadParameter: "", httpMethod: .post, ShowLoader: true, ShowTrueFalseValue: true, RetryMethod: apiSendMessage) { (response) in

            
            print(response!)
            let status = response?[0]["status"] as? String ?? ""
            let message = response?[0]["error_msg"] as? String ?? ""
            if status == "1"{
                // UIAlertController().simpleMessageWithSingleAction(action: {
                self.msgTxtField.text = ""
                self.apiGetMessageList()

                //  }, title: message, message: "", presentOn: self)
            }else{
                UIAlertController().Simplealert(withTitle: message, Message: "", presentOn: self)

            }
        }
    }
    
    //api upload image
    func apiSendMessageWithImage(){
        
        let parameter : [String : Any] = [:]
        
        print(parameter)
        let sendMessage = ""

        ServiceManager.shared.MakeApiCall(ForServiceName: sendMessage, withParameters: parameter, withAttachments: nil, withAttachmentName: [""], UploadParameter: "", httpMethod: .post, ShowLoader: true, ShowTrueFalseValue: true, RetryMethod: apiSendMessageWithImage) { (response) in
            
            print(response!)
            let status = response?[0]["status"] as? String ?? ""
            let message = response?[0]["error_msg"] as? String ?? ""
            if status == "1"{
                // UIAlertController().simpleMessageWithSingleAction(action: {
                self.msgTxtField.text = ""
                self.apiGetMessageList()
                
                //  }, title: message, message: "", presentOn: self)
            }else{
                UIAlertController().Simplealert(withTitle: message, Message: "", presentOn: self)
                
            }
        }
    }
    
   
    
    
    //api get image message list
    func apiGetMessageList(){
        let parameters : [String:Any] = [:]
        
        print(parameters)
        let messageShow = ""
        ServiceManager.shared.MakeApiCall(ForServiceName: messageShow, withParameters: parameters, withAttachments: nil, withAttachmentName: nil, UploadParameter: nil, httpMethod: .get, ShowLoader: false, ShowTrueFalseValue: true, RetryMethod: {
          self.apiGetMessageList()
        }) {  (response) in
            
              print(response!)
            let status = response?[0]["status"] as? String ?? ""
            let message = response?[0]["error_msg"] as? String ?? ""
            if status == "1"{
                self.messageData  = response?[0]["data"] as? [[String:Any]] ?? [[:]]
              
                let last_id = self.messageData.last!["id"] as? String ?? ""
                self.chatTableView.reloadData()
                if last_id == self.last_msg_id {

                }else{
                    
                    self.last_msg_id = self.messageData.last!["id"] as? String ?? ""
                    self.chatTableView.reloadData()
                   // self.chatTableView.scrollToRow(at: IndexPath.init(row: (self.messageData[self.messageData.count - 1]["data"] as? [[String:Any]] ?? [[:]]).count - 1, section: 0), at: .bottom, animated: false)
                    
                    self.chatTableView.scrollToRow(at: IndexPath.init(row: (self.messageData.count - 1), section: 0), at: .bottom, animated: false)
                }
                
            }else{
                // UIAlertController().Simplealert(withTitle: message, Message: "", presentOn: self)
            }
            
        }
    }
}

class ChatTableViewCell: UITableViewCell {
    
    
    // create IBoutlet beacuse of image height decrease
    @IBOutlet weak var img_reciver_con: NSLayoutConstraint! // 150
    @IBOutlet weak var reciver_stact_con: NSLayoutConstraint! // 30
    @IBOutlet weak var img_sender_con: NSLayoutConstraint! // 150
    @IBOutlet weak var sender_stack_con: NSLayoutConstraint! // 30
    
    
    @IBOutlet weak var receiverView: UIView!
    @IBOutlet weak var ReceiverImage: UIImageView!
    @IBOutlet weak var lblReceiverMsg: UILabel!
    @IBOutlet weak var lblsenderMsg: UILabel!
    
   
    @IBOutlet weak var ReceiverGetImage: UIImageView!
    @IBOutlet weak var senderLblTime: UILabel!
    @IBOutlet weak var LocationName: UILabel!
    @IBOutlet weak var receivertime: UILabel!
    
    
    @IBOutlet weak var receiverStackView: UIStackView!
    @IBOutlet weak var senderStackView: UIStackView!
    
    @IBOutlet weak var senderLocationName: UILabel!
    @IBOutlet weak var sendertime: UILabel!
    
   
    @IBOutlet weak var senderSendImge: UIImageView!
    @IBOutlet weak var senderView: UIView!
    @IBOutlet weak var receiverLblTime: UILabel!
    @IBOutlet weak var senderImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
      
        
        ReceiverImage.layer.cornerRadius = ReceiverImage.frame.size.height / 2
      //  ReceiverImage.layer.borderColor = UIColor(red: 0/255, green: 148/255, blue: 0/255, alpha: 1).cgColor
       // ReceiverImage.layer.borderWidth = 2
        ReceiverImage.clipsToBounds = true
        
       
        senderImage.layer.cornerRadius = senderImage.frame.size.height / 2
       // senderImage.layer.borderColor = UIColor(red: 0/255, green: 148/255, blue: 0/255, alpha: 1).cgColor
       // senderImage.layer.borderWidth = 2
        senderImage.clipsToBounds = true
        
    }
        
        // Initialization code
}

//MARK:- Public

extension ChatTableViewCell {
    func fill(message: TestChat)  {
        //Do logic here
    }
}

//MARK:- Private

private extension ChatTableViewCell { //Private extensions go here

}

//MARK:- pickerView Delegate
extension PersonalChatVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true) {
            let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            //self.selectedImage = image
          //  self.SendMessages()
        }
    }
}
