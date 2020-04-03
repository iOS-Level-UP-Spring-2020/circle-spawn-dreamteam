//
//  CGFloat.swift
//  CircleSpawn
//
//  Created by Taras Kulyavets on 03.04.2020.
//  Copyright © 2020 DaftAcademy. All rights reserved.
//

import UIKit

extension CGFloat {
  static func random() -> CGFloat {
    return random(min: 0.0, max: 1.0)
  }

  static func random(min: CGFloat, max: CGFloat) -> CGFloat {
    assert(max > min)
    return min + ((max - min) * CGFloat(arc4random()) / CGFloat(UInt32.max))
  }
}
