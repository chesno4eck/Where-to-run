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
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var buttonsView: UIView!
    
    @IBAction func tabBarButtonPressed(_ sender: Any) {
        buttonsView.isHidden = !buttonsView.isHidden
    }
    
    private var currentlyConnectedMacAdress:String? {didSet{
        if let mac = currentlyConnectedMacAdress {
            historyMacAdresses.append(mac)
            lbl.text = mac
            highlightCurrentSector()
        }
        }}
    
    private var timer = Timer()
    
    // MARK: To remove
    private var historyMacAdresses:[String] = [] {didSet{
    
    }}
    //MARK: End to remove
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupGestureRecognizer()
        
        writeToFile(value: "-----------\(Date())-----------")
        startLocatingMe()
    }
    
    private func setupScrollView(){
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 1.0
    }

    private func highlightCurrentSector(){
        mapImageView.subviews.forEach { $0.removeFromSuperview() }
        
        if let point = AccessPoints().valuesArray.filter({ (_,_,m) -> Bool in
            m == currentlyConnectedMacAdress
        }).first {
            let view = UIView(frame: CGRect(x: ((Int(point.0)) * Int(mapImageView.frame.width))/100 - 80,
                                            y: ((Int(point.1)) * Int(mapImageView.frame.height))/100 - 80,
                                            width: 160,
                                            height: 160))
            view.layer.cornerRadius = 80
            view.layer.masksToBounds = true
            view.backgroundColor = UIColor.blue
            view.alpha = 0.4
            mapImageView.addSubview(view)
        }
        
    }
    
    
    private func setupGestureRecognizer(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(taps))
        mapImageView.addGestureRecognizer(tap)
        mapImageView.isUserInteractionEnabled = true
    }
    
    
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
    
// DEBUG ZONE
    
    /*
    private func createAllPoints(){
     for point in AccessPoints().valuesArray {
     let view = UIView(frame: CGRect(x: ((Int(point.0)) * Int(mapImageView.frame.width))/100 - 80,
     y: ((Int(point.1)) * Int(mapImageView.frame.height))/100 - 80,
     width: 160,
     height: 160))
     view.layer.cornerRadius = 80
     view.layer.masksToBounds = true
     view.backgroundColor = UIColor.blue
     view.alpha = 0.4
     mapImageView.addSubview(view)
     }
     }
     */
    
    /*
    private func writeToLog(){
        if let ssid = currentlyConnectedWifiData().SSID, let mac = currentlyConnectedWifiData().MAC {
            print("Вы подключены к точке \(ssid) с MAC адресом: \(mac)")
        } else {
            print("Похоже, вы не подключены ни к какому wifi")
        }
    }
     */
}
