//
//  NoInternetVC.swift
//  Meal_Do
//
//  Created by Dipak Kasodariya on 10/09/19.
//  Copyright © 2019 Dhaval. All rights reserved.
//

import UIKit
import Reachability

protocol CheckInternetDelegate{
    func Checknet(AvailableInterner: Bool)
}

class NoInternetVC: UIViewController {
    
    //These properties can probalyby private
    var reachability: Reachability?
    let hostNames = [nil, "google.com", "invalidhost"]
    var hostIndex = 0
    @IBOutlet weak var btnTryAgain: UIButton! // move this to separate space. Doesnt look neet here.
    var NoInternetViewController :NoInternetVC?
    var checkNet : CheckInternetDelegate? // delegate should be weak to avoid retain cyle
    
    override func viewDidLoad() { //This can be removed.
        super.viewDidLoad()

        //Remove comments
        // Do any additional setup after loading the view.
    }
    
    //Remove weird capitalization
    @IBAction func btnTryAgainPRessed(_ sender: Any) {
        
            reachability = Reachability.init()
            if ((self.reachability!.connection) != .none) {
                do {
                    try reachability!.startNotifier()
                } catch {
                    print("Unable to start notifier")
                }
                self.dismiss(animated: true, completion: nil)

            } else{
//                do {
//                    try reachability!.startNotifier()
//                } catch {
//                    print("Unable to start notifier")
//                }
                print("Internet is nO ok")
//                let storyboard = UIStoryboard.init(name: "side_menu", bundle: nil)
//                let controller  = storyboard.instantiateViewController(withIdentifier: "NoInternetVC")as! NoInternetVC
//                controller.view.frame = self.view.bounds;
//                self.addChild(controller)
//                self.view.addSubview(controller.view)
//                controller.didMove(toParent: self)
                
            }
            
        
        
       // self.dismiss(animated: true, completion: nil)

    // navigationController?.popViewController(animated: true)
       
    }
    
    func TryAgain(presentOn vc:UIViewController,retry:(()->())?){
        reachability = Reachability.init()
        if ((self.reachability!.connection) != .none) {
            do {
                try reachability!.startNotifier()
            } catch {
                print("Unable to start notifier")
            }
           self.dismiss(animated: true, completion: nil)
        } else{
            //                do {
            //                    try reachability!.startNotifier()
            //                } catch {
            //                    print("Unable to start notifier")
            //                }
            print("Internet is nO ok")
            //                let storyboard = UIStoryboard.init(name: "side_menu", bundle: nil)
            //                let controller  = storyboard.instantiateViewController(withIdentifier: "NoInternetVC")as! NoInternetVC
            //                controller.view.frame = self.view.bounds;
            //                self.addChild(controller)
            //                self.view.addSubview(controller.view)
            //                controller.didMove(toParent: self)
            
        }
}
    
   

}
