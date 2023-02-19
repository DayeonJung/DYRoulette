//
//  UILabel+Extension.swift
//  roulette
//
//  Created by Dayeon Jung on 2023/02/19.
//

import UIKit

extension UILabel {
  func autoScale() {
    self.numberOfLines = 1
    self.adjustsFontSizeToFitWidth = true
    self.minimumScaleFactor = 0.5
    self.lineBreakMode = .byCharWrapping
  }
}
