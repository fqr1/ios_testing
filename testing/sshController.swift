//
//  sshController.swift
//  testing
//
//  Created by Fabián Quintero Romo on 19/03/16.
//  Copyright © 2016 Fabián Quintero Romo. All rights reserved.
//

import UIKit

class sshController: UIViewController, SimplePingDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func sshConnection() {
        sshIn()
    }
    
    func sshIn() {
//        let task = NSTask()
//        task.launchPath = "/usr/bin/ssh"
//        task.arguments = ["USERNAME@IPADDRESS", "-t", "sudo systemctl stop mediacenter; /opt/vc/bin/tvservice -o"]
//        task.launch()
    }
    
    private var pingTimer: NSTimer?
    private var lastSequenceSent: UInt16?
    private var lastSentTime: NSDate?
    
    var canStartPinging = false
    @IBAction func testConnection() {
        
        //isConnectedToNetwork()
        //*
        var pinger = SimplePing(hostName: "www.google.com")
        pinger.delegate = self
        pinger.start()
        
        var count = 5
        
        repeat {
            if (canStartPinging) {
                pinger.sendPingWithData(nil)
                count--
                //print("COUNT... \(count)")
                
                if count == 0{
                    pinger = nil
                }
            }
            NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate.distantFuture())
        } while(pinger != nil)
//*/
    }
    
    func simplePing(pinger: SimplePing!, didStartWithAddress address: NSData!) {
        print("didStartWithAddress")
        canStartPinging = true
    }
    
    func simplePing(pinger: SimplePing!, didFailToSendPacket packet: NSData!, error: NSError!) {
        print("didFailToSendPacket")
    }
    
    func simplePing(pinger: SimplePing!, didFailWithError error: NSError!) {
        print("didFailWithError")
        
    }
    
    func simplePing(pinger: SimplePing!, didReceiveUnexpectedPacket packet: NSData!) {
        print("didReceiveUnexpectedPacket")
    }
    
    
    func simplePing(pinger: SimplePing!, didSendPacket packet: NSData!) {
        print("didSendPacket")
    
        lastSentTime = NSDate()
    }
    
    func simplePing(pinger: SimplePing!, didReceivePingResponsePacket packet: NSData!) {
        print("didReceivePingResponsePacket")
        
        let seqNo = CFSwapInt16BigToHost(SimplePing.icmpInPacket(packet).memory.sequenceNumber)
        
        if let lastTime = lastSentTime {
            let lastLag = NSDate().timeIntervalSinceDate(lastTime) * 1_000
            print("pong \(seqNo) - lag \(lastLag)")
        }
    }
    
    
    func isConnectedToNetwork()->Bool{
        
        var Status:Bool = false
        let url = NSURL(string: "http://google.com/")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "HEAD"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 2.0
        
        var response: NSURLResponse?
        
        
        do{
            lastSentTime = NSDate()
            _ = try NSURLConnection.sendSynchronousRequest(request,returningResponse: &response) as NSData?
            let lastLag = NSDate().timeIntervalSinceDate(lastSentTime!) * 1_000
            print("Latency: \(lastLag)")
        }catch {
            
        }
        
        //print("RESPONSE \(response)")
        if let httpResponse = response as? NSHTTPURLResponse {
            if httpResponse.statusCode == 200 {
                Status = true
            }
        }
        
        return Status
    }

   

}
