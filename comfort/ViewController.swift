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
    let finder = PathFinder()
    
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mapImageView: UIImageView!
    @IBOutlet weak var buttonsView: UIView!
    
    @IBAction func tabBarButtonPressed(_ sender: Any) {
        buttonsView.isHidden = !buttonsView.isHidden
    }
    
    @IBAction func buttonToiletPressed(_ sender: Any) {
        showPath(to: .toilet)
        buttonsView.isHidden = true
    }
    @IBAction func buttonKitchenPressed(_ sender: Any) {
        showPath(to: .kitchen)
        buttonsView.isHidden = true
    }
    @IBAction func buttonLiftPressed(_ sender: Any) {
        showPath(to: .lift)
        buttonsView.isHidden = true
    }
    @IBAction func buttonRazdevalkaPressed(_ sender: Any) {
        showPath(to: .razdevalra)
        buttonsView.isHidden = true
    }
    
    
    private var currentlyConnectedMacAdress:String? {
        didSet {
            if let mac = currentlyConnectedMacAdress {
                lbl.text = mac
                highlightCurrentSector()
            }
        }
    }
    
    private var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        startLocatingMe()
    }
    
    private func setupScrollView(){
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 1.0
    }

    func showPath(to poi: Point){
        guard let mac = currentlyConnectedMacAdress,
            let point = AccessPoints.valuesDict[mac] else {return}
        let myCoordinates = Coordinates(x: point.0, y: point.1)
        
        if myCoordinates.x > 100 && myCoordinates.y > 100 {
            return
        }
        let positionInMapX:Int = myCoordinates.x
        let positionInMapY:Int = Int(myCoordinates.y/2)
        
        a(Coordinates(x: positionInMapX, y: positionInMapY), point: poi)
    }
    
    func a(_ myCoordinate: Coordinates, point: Point) {
        guard let pathToTropa = finder.findTropa(from: myCoordinate) else { return }
        if let pathToPoint = finder.findPath(from: pathToTropa.first ?? myCoordinate, to: point) {
            drawPath(path: pathToPoint + pathToTropa)
        }
    }
    
    func drawPath(path: [Coordinates]) {
        mapImageView.subviews.forEach { $0.removeFromSuperview() }
        for coo in path {
            let view = UIView(frame: CGRect(
                x: CGFloat(coo.x) * mapImageView.frame.width / 100,
                y: CGFloat(coo.y) * mapImageView.frame.height / 50,
                width: mapImageView.frame.width / 100,
                height: mapImageView.frame.height / 100
            ))
            view.alpha = 0.7
            view.backgroundColor = UIColor.green
            mapImageView.addSubview(view)
            
        }
    }
    
    private func highlightCurrentSector(){
        mapImageView.subviews.forEach { $0.removeFromSuperview() }
        
        if let mac = currentlyConnectedMacAdress,
            let point = AccessPoints.valuesDict[mac] {
            
            let scaleFactorByX = Int(mapImageView.frame.width)/100
            let scaleFactorByY = Int(mapImageView.frame.height)/50
            let pointRadius = 10
            
            let view = UIView(frame: CGRect(x: ((Int(point.0)) * scaleFactorByX - (pointRadius/2 * scaleFactorByX)),
                                            y: ((Int(point.1)) * scaleFactorByY - (pointRadius/2 * scaleFactorByY)),
                                            width: 2 * pointRadius * scaleFactorByX,
                                            height: 2 * pointRadius * scaleFactorByX))
            view.layer.cornerRadius = CGFloat(pointRadius * scaleFactorByX)
            view.layer.masksToBounds = true
            view.backgroundColor = UIColor.blue
            view.alpha = 0.4
            mapImageView.addSubview(view)
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
}
