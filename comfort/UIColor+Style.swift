//
// Created by Альбицкий Павел Сергеевич on 24.05.16.
// Copyright (c) 2016 Pavel Albitsky. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class var lightGreyColor: UIColor {
        return UIColor(white: 226.0 / 255.0, alpha: 1.0)
    }
    
    class var squashColor: UIColor {
        return UIColor(red: 246.0 / 255.0, green: 166.0 / 255.0, blue: 35.0 / 255.0, alpha: 1.0)
    }
    
    class var alert: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 106.0 / 255.0, blue: 89.0 / 255.0, alpha: 1.0)
    }
    
    class var silverTwo: UIColor {
        return UIColor(red: 219.0 / 255.0, green: 221.0 / 255.0, blue: 222.0 / 255.0, alpha: 1.0)
    }
    
    class var reddish: UIColor {
        return UIColor(red: 193.0 / 255.0, green: 64.0 / 255.0, blue: 50.0 / 255.0, alpha: 1.0)
    }
    
    class var styleMacaroniAndCheeseColor: UIColor {
        return UIColor(red: 242.0 / 255.0, green: 180.0 / 255.0, blue: 72.0 / 255.0, alpha: 1.0)
    }
    
    class var gunmetal: UIColor {
        return UIColor(red: 75.0 / 255.0, green: 84.0 / 255.0, blue: 91.0 / 255.0, alpha: 1.0)
    }
    
    class var algae: UIColor {
        return UIColor(red: 83.0 / 255.0, green: 179.0 / 255.0, blue: 116.0 / 255.0, alpha: 1.0)
    }
    
    class var softGreen: UIColor {
        return UIColor(red: 117.0 / 255.0, green: 194.0 / 255.0, blue: 144.0 / 255.0, alpha: 1.0)
    }
    
    class var windowsBlue: UIColor {
        return UIColor(red: 58.0 / 255.0, green: 130.0 / 255.0, blue: 198.0 / 255.0, alpha: 1.0)
    }
    
    class var windowsBlueTwo: UIColor {
        return UIColor(red: 52.0 / 255.0, green: 117.0 / 255.0, blue: 178.0 / 255.0, alpha: 1.0)
    }
    
    class var algaeTwo: UIColor {
        return UIColor(red: 74.0 / 255.0, green: 161.0 / 255.0, blue: 104.0 / 255.0, alpha: 1.0)
    }
    
    class var paleGrey: UIColor {
        return UIColor(red: 242.0 / 255.0, green: 244.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
    }
    
    class var twilightBlue: UIColor {
        return UIColor(red: 10.0 / 255.0, green: 91.0 / 255.0, blue: 114.0 / 255.0, alpha: 1.0)
    }
    
    class var paleGreyThree: UIColor {
        return UIColor(red: 247.0 / 255.0, green: 248.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
    }

    class var paleGreyFour: UIColor {
        return UIColor(red: 250.0 / 255.0, green: 251.0 / 255.0, blue: 251.0 / 255.0, alpha: 1.0)
    }
    
    class var lightBlueGrey: UIColor {
        return UIColor(red: 221.0 / 255.0, green: 240.0 / 255.0, blue: 227.0 / 255.0, alpha: 1.0)
    }
    
    class var cornflowerBlue: UIColor {
        return UIColor(red: 97.0 / 255.0, green: 155.0 / 255.0, blue: 209.0 / 255.0, alpha: 1.0)
    }
    
    class var lightTan: UIColor {
        return UIColor(red: 251.0 / 255.0, green: 219.0 / 255.0, blue: 167.0 / 255.0, alpha: 1.0)
    }
    
    class var pinkishGrey: UIColor {
        return UIColor(red: 196.0 / 255.0, green: 196.0 / 255.0, blue: 196.0 / 255.0, alpha: 1.0)
    }
    
    class var coolGrey: UIColor {
        return UIColor(red: 147.0 / 255.0, green: 152.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
    }
    
    class var battleshipGrey: UIColor {
        return UIColor(red: 111.0 / 255.0, green: 118.0 / 255.0, blue: 124.0 / 255.0, alpha: 1.0)
    }
    
    class var inactiveText: UIColor {
        return UIColor(red: 142/255.0, green: 142/255.0, blue: 147/255.0, alpha: 1)
    }
    
    class var selectedCellColor: UIColor {
        return UIColor.black.withAlphaComponent(0.1)
    }
    
    class var generatedColor: UIColor {
        let red = CGFloat(arc4random_uniform(200)) / 255.0
        let green = CGFloat(arc4random_uniform(200)) / 255.0
        let blue = CGFloat(arc4random_uniform(200)) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

// MARK: - Initials view colors

extension UIColor {
    class var initialsViewColors: [UIColor] {
        return [
            UIColor(red: 1.00, green: 0.34, blue: 0.22, alpha: 1.0),
            UIColor(red: 0.94, green: 0.38, blue: 0.57, alpha: 1.0),
            UIColor(red: 0.73, green: 0.41, blue: 0.78, alpha: 1.0),
            UIColor(red: 0.58, green: 0.46, blue: 0.80, alpha: 1.0),
            UIColor(red: 0.47, green: 0.53, blue: 0.80, alpha: 1.0),
            UIColor(red: 0.39, green: 0.71, blue: 0.96, alpha: 1.0),
            UIColor(red: 0.31, green: 0.76, blue: 0.97, alpha: 1.0),
            UIColor(red: 0.30, green: 0.82, blue: 0.88, alpha: 1.0),
            UIColor(red: 0.30, green: 0.71, blue: 0.67, alpha: 1.0),
            UIColor(red: 0.51, green: 0.78, blue: 0.52, alpha: 1.0),
            UIColor(red: 0.68, green: 0.84, blue: 0.51, alpha: 1.0),
            UIColor(red: 1.00, green: 0.54, blue: 0.40, alpha: 1.0),
            UIColor(red: 0.83, green: 0.88, blue: 0.34, alpha: 1.0),
            UIColor(red: 1.00, green: 0.84, blue: 0.31, alpha: 1.0),
            UIColor(red: 1.00, green: 0.72, blue: 0.30, alpha: 1.0),
            UIColor(red: 0.63, green: 0.53, blue: 0.50, alpha: 1.0),
            UIColor(red: 0.56, green: 0.64, blue: 0.68, alpha: 1.0)
        ]
    }
}
