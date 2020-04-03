//
//  UIColor.swift
//  CircleSpawn
//
//  Created by Taras Kulyavets on 03.04.2020.
//  Copyright © 2020 DaftAcademy. All rights reserved.
//

import UIKit

extension UIColor {
  static func randomBrightColor() -> UIColor {
    return UIColor(hue: .random(),
             saturation: .random(min: 0.5, max: 1.0),
             brightness: .random(min: 0.7, max: 1.0),
             alpha: 1.0)
  }
}
