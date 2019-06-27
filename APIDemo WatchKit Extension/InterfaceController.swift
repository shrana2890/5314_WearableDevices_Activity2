//
//  InterfaceController.swift
//  APIDemo WatchKit Extension
//
//  Created by Parrot on 2019-03-03.
//  Copyright © 2019 Parrot. All rights reserved.
//

import WatchKit
import Foundation
import Alamofire
import SwiftyJSON
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    let session : WCSession = (WCSession.isSupported() ? WCSession.default : nil)!
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    
    // MARK: Outlet
    // ---------------
 
    @IBOutlet var watchOutputLabel: WKInterfaceLabel!
    
    
    // MARK: Actions
    @IBAction func getDataPressed() {
        print("Watch button pressed")
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
         if (WCSession.default.isReachable) {
            let noti = ["data" : "Hello Phone"]
            session.sendMessage(noti, replyHandler: { (replyData) in
                print("Send Message From watch is : \(replyData)")
                WKInterfaceDevice.current().play(WKHapticType.notification)
            }, errorHandler: { (error) in
                print("Send Message From watch is : \(error)")
            })
            }
     
         else {
            print("Watch Side:Cannot find phone")
        }
        
   
    }
    
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }

        
    }
   
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        
        
        WKInterfaceDevice().play(.click)
        
        
        
        // output a debug message to the terminal
        print("Watch Side : Got a message!")
        
        // update the message with a label
        watchOutputLabel.setText("\(message["data"]!)")
        print("Watch Side:output is \(message)")
    }
   
}
