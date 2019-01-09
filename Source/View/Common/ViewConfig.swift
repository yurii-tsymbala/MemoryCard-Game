//
//  ViewConfig.swift
//  MemoryCard Game
//
//  Created by Yurii Tsymbala on 1/7/19.
//  Copyright © 2019 Yurii Tsymbala. All rights reserved.
//

import UIKit

struct ViewConfig {
  struct Colors {
    // used for background color
    static let background = UIColor(red: 0.17, green: 0.17, blue: 0.20, alpha: 1.00)
    // used for navigation bar
    static let dark = UIColor(red: 0.12, green: 0.13, blue: 0.16, alpha: 1.00)
    // main white color
    static let white = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
    // used for text fields
    static let grey = UIColor(red: 0.26, green: 0.26, blue: 0.29, alpha: 1.00)
    // used for buttons
    static let blue = UIColor(red: 0.03, green: 0.37, blue: 0.62, alpha: 1.00)
    static let textWhite = UIColor(red: 0.95, green: 0.95, blue: 0.92, alpha: 1.00)
    static let textLightGrey = UIColor(red: 0.53, green: 0.53, blue: 0.56, alpha: 1.00)
    static var grayLighter = UIColor(red: 0.26, green: 0.30, blue: 0.33, alpha: 1.0)
    static var grayLight = UIColor(red: 0.15, green: 0.17, blue: 0.18, alpha: 1.0)
    static var grayDark = UIColor(red: 0.08, green: 0.09, blue: 0.11, alpha: 1.0)
    static var grayDarkAlpha = UIColor(red: 0.08, green: 0.09, blue: 0.11, alpha: 0.7)
    static var cancelButtonColor = #colorLiteral(red: 1, green: 0.2216856198, blue: 0.2313298065, alpha: 1)
    static let priorityHight = #colorLiteral(red: 1, green: 0.2216856198, blue: 0.2313298065, alpha: 1)
    static let priorityNormal = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    static let priorityLow = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
  }

  struct Design {
    static var cornerRadius: CGFloat { return 6.0 }
    static var enabledButtonAlpha: CGFloat { return 1 }
    static var disabledButtonAlpha: CGFloat { return 0.5 }
  }

  struct Fonts {
    static let callout = UIFont.systemFont(ofSize: 14.0)
  }
}
