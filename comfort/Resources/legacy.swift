//
//  legacy.swift
//  comfort
//
//  Created by Алиев Дмитрий on 21/06/2018.
//  Copyright © 2018 Алиев Дмитрий. All rights reserved.
//

import Foundation

/*
private func createAllPoints(){
    for point in AccessPoints.valuesDict {
        let scaleFactorByX = Int(mapImageView.frame.width)/100
        let scaleFactorByY = Int(mapImageView.frame.height)/100
        let pointRadius = 10
        
        let view = UIView(frame: CGRect(x: ((Int(point.value.0)) * scaleFactorByX - (pointRadius/2 * scaleFactorByX)),
                                        y: ((Int(point.value.1)) * scaleFactorByY - (pointRadius/2 * scaleFactorByY)),
                                        width: 2 * pointRadius * scaleFactorByX,
                                        height: 2 * pointRadius * scaleFactorByX))
        view.layer.cornerRadius = CGFloat(pointRadius * scaleFactorByX)
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.blue
        view.alpha = 0.4
        mapImageView.addSubview(view)
    }
    
}



 private func writeToLog(){
 if let ssid = currentlyConnectedWifiData().SSID, let mac = currentlyConnectedWifiData().MAC {
 print("Вы подключены к точке \(ssid) с MAC адресом: \(mac)")
 } else {
 print("Похоже, вы не подключены ни к какому wifi")
 }
 }
 */

/*
func drawNet() {
    mapImageView.subviews.forEach { $0.removeFromSuperview() }
    let net = netString.replacingOccurrences(of: "\n", with: "")
    for y in 0..<50 {
        for x in 0..<100 {
            let view = UIView(frame: CGRect(
                x: CGFloat(x) * mapImageView.frame.width / 100,
                y: CGFloat(y) * mapImageView.frame.height / 50,
                width: mapImageView.frame.width / 100,
                height: mapImageView.frame.height / 50
            ))
            view.alpha = 0.7
            
            switch net[y * 100 + x] {
            case "0":
                break
            case "1": // сетка
                view.backgroundColor = UIColor.lightGray
                mapImageView.addSubview(view)
            case "t": // туалет
                view.backgroundColor = UIColor.blue
                mapImageView.addSubview(view)
            case "c": // кофе
                view.backgroundColor = UIColor.brown
                mapImageView.addSubview(view)
            case "f": // футбол
                view.backgroundColor = UIColor.black
                mapImageView.addSubview(view)
            case "k": // кухня
                view.backgroundColor = UIColor.yellow
                mapImageView.addSubview(view)
            case "r": // раздевалка
                view.backgroundColor = UIColor.red
                mapImageView.addSubview(view)
            case "l": // лифт
                view.backgroundColor = UIColor.green
                mapImageView.addSubview(view)
            case "w": // way
                view.backgroundColor = UIColor.windowsBlue
                mapImageView.addSubview(view)
            case "s": // start
                view.backgroundColor = UIColor.black
                mapImageView.addSubview(view)
            default: break
            }
        }
    }
}
 
 private func setupGestureRecognizer(){
     let tap = UITapGestureRecognizer(target: self, action: #selector(taps))
     mapImageView.addGestureRecognizer(tap)
     mapImageView.isUserInteractionEnabled = true
 }

 
 @objc func taps(sender: UITapGestureRecognizer) {
     if sender.state == .ended {
     let tapVertical = sender.location(in: mapImageView).y / mapImageView.frame.height * 50 * scrollView.zoomScale
     let tapHorizont = sender.location(in: mapImageView).x / mapImageView.frame.width * 100 * scrollView.zoomScale
     if let mac = currentlyConnectedMacAdress {
     writeToFile(value: "\(tapHorizont), \(tapVertical), \(mac)")
     let view = UIView(frame: CGRect(x: sender.location(in: mapImageView).x - 20, y: sender.location(in: mapImageView).y - 20, width: 40, height: 40))
     view.backgroundColor = UIColor.red
     view.alpha = 0.4
     mapImageView.addSubview(view)
     }
 }
 }

*/
