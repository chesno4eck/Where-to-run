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

    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mapImageView: UIImageView!
    
    
    var points:[(Float,Float,String)] = [(65,8,"0:a6:ca:10:8a:42"),(65,7,"0:a6:ca:10:8a:4d"),(47,11,"0:a6:ca:10:b0:e2"),(95,28,"95,28,0:a6:ca:2d:7b:d2"),(97,20,"0:a6:ca:35:93:f2"),(41,11,"0:a6:ca:56:42:7d"),(89,12,"0:a6:ca:56:c:92"),(83,10,"0:a6:ca:56:c:e2"),(94,18,"0:a6:ca:56:e:72"),(75,9,"0:a6:ca:68:9d:a2"),(45,8,"0:a6:ca:68:a3:fd")]
    
    private var currentlyConnectedMacAdress:String? {didSet{
        if let mac = currentlyConnectedMacAdress {
            historyMacAdresses.append(mac)
            lbl.text = mac
            highlightCurrentSector()
        }
        }}
    private var timer = Timer()
    private var historyMacAdresses:[String] = [] {didSet{
        print(historyMacAdresses.last)
        writeToLog()
    }}

    override func viewDidLoad() {
        super.viewDidLoad()
        writeToFile(value: "-----------\(Date())-----------")
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 1.0
        startLocatingMe()

        let tap = UITapGestureRecognizer(target: self, action: #selector(taps))
        mapImageView.addGestureRecognizer(tap)
        mapImageView.isUserInteractionEnabled = true
        
    }

    func highlightCurrentSector(){
        //mapImageView.subviews.forEach { $0.removeFromSuperview() }
        if let point = points.filter({ (_,_,m) -> Bool in
            m == currentlyConnectedMacAdress
        }).first {
            let view = UIView(frame: CGRect(x: ((Int(point.0)) * Int(mapImageView.frame.width))/100 - 40,
                                            y: ((Int(point.1)) * Int(mapImageView.frame.height))/100 - 40,
                                            width: 80,
                                            height: 80))
            view.backgroundColor = UIColor.blue
            view.alpha = 0.4
            mapImageView.addSubview(view)
        }
        
    }
    
    /*
    func createPoints(){
        for point in points {
            let view = UIView(frame: CGRect(x: ((Int(point.0)) * Int(mapImageView.frame.width))/100 - 40,
                                            y: ((Int(point.1)) * Int(mapImageView.frame.height))/100 - 40,
                                            width: 80,
                                            height: 80))
            view.backgroundColor = UIColor.blue
            view.alpha = 0.4
            mapImageView.addSubview(view)
        }
    }
    */
    @objc func taps(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let tapVertical = sender.location(in: mapImageView).y / mapImageView.frame.height * 100 * scrollView.zoomScale
            let tapHorizont = sender.location(in: mapImageView).x / mapImageView.frame.width * 100 * scrollView.zoomScale
            print("\(tapHorizont), \(tapVertical)")
            if let mac = currentlyConnectedMacAdress {
                writeToFile(value: "\(tapHorizont), \(tapVertical), \(mac)")
                let view = UIView(frame: CGRect(x: sender.location(in: mapImageView).x - 20, y: sender.location(in: mapImageView).y - 20, width: 40, height: 40))
                view.backgroundColor = UIColor.red
                view.alpha = 0.4
                mapImageView.addSubview(view)
            }
        }
    }
}
extension ViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mapImageView
    }
}


extension ViewController {
    
    private func startLocatingMe(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.wifiIterator), userInfo: nil, repeats: true)
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
