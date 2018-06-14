//
//  MainMutton.swift
//  comfort
//
//  Created by Алиев Дмитрий on 14/06/2018.
//  Copyright © 2018 Алиев Дмитрий. All rights reserved.
//

import UIKit

class MainButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5
        clipsToBounds = true
        
        tintColor = UIColor.white
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
        setTitleColor(UIColor.gunmetal, for: UIControlState())
        setTitleColor(UIColor.gunmetal, for: .highlighted)
        backgroundColor = UIColor.lightBlueGrey
    }

}
