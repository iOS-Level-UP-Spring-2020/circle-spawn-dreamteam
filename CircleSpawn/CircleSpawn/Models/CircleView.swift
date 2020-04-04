//
//  Circle.swift
//  CircleSpawn
//
//  Created by Hanna on 4/3/20.
//  Copyright © 2020 DaftAcademy. All rights reserved.
//

import Foundation
import UIKit

class CircleView: UIView {
    
    init() {
        let frame = CGRect(origin: CGPoint(), size: CGSize(width: 100, height: 100))
        super.init(frame: frame)
        layer.cornerRadius = 50
        backgroundColor = UIColor.randomBrightColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
}
