//
//  ViewController.swift
//  comfort
//
//  Created by Алиев Дмитрий on 14/06/2018.
//  Copyright © 2018 Алиев Дмитрий. All rights reserved.
//

import UIKit
import NetworkExtension
import SystemConfiguration.CaptiveNetwork

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mapImageView: UIImageView!
    
    private var currentlyConnectedMacAdress:String? {didSet{
        if currentlyConnectedMacAdress != nil {
            historyMacAdresses.append(currentlyConnectedMacAdress!)
        }
        }}
    private var timer = Timer()
    private var historyMacAdresses:[String] = [] {didSet{
        print(historyMacAdresses.last)
        writeToLog()
    }}

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        startLocatingMe()

        let tap = UITapGestureRecognizer(target: self, action: #selector(addPoint))
        mapImageView.addGestureRecognizer(tap)
    }

    @objc func addPoint() {
        
    }
}
extension ViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mapImageView
    }
}


extension ViewController {
    
    private func startLocatingMe(){
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.wifiIterator), userInfo: nil, repeats: true)
    }
    
    @objc private func wifiIterator() {
        if currentlyConnectedWifiData().MAC == currentlyConnectedMacAdress {
            return
        }
        currentlyConnectedMacAdress = currentlyConnectedWifiData().MAC
    }
    
    private func currentlyConnectedWifiData() -> (SSID:String?, MAC:String?){
        let informationArray:NSArray? = CNCopySupportedInterfaces()
        var wifiCharDictionary: [String:String?] = [:]
        if let information = informationArray {
            let dict:NSDictionary? = CNCopyCurrentNetworkInfo(information[0] as! CFString)
            if let temp = dict {
                wifiCharDictionary["SSID"] = temp["SSID"]! as? String
                wifiCharDictionary["BSSID"] = temp["BSSID"]! as? String
                return (SSID:wifiCharDictionary["SSID"]!, MAC:wifiCharDictionary["BSSID"]!)
            }
        }
        return (SSID:nil, MAC:nil)
    }
    
    private func writeToLog(){
        // Logging
        if let ssid = currentlyConnectedWifiData().SSID, let mac = currentlyConnectedWifiData().MAC {
            print("Вы подключены к точке \(ssid) с MAC адресом: \(mac)")
        } else {
            print("Похоже, вы не подключены ни к какому wifi")
        }
        // Logging
    }

}
