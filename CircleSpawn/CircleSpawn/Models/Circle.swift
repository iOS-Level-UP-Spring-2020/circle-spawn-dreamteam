//
//  Circle.swift
//  CircleSpawn
//
//  Created by Hanna on 4/3/20.
//  Copyright © 2020 DaftAcademy. All rights reserved.
//

import Foundation
import UIKit

class Circle: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 50
        backgroundColor = UIColor.randomBrightColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
}
