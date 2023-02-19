//
//  ArrowView.swift
//  roulette
//
//  Created by Dayeon Jung on 2023/02/19.
//

import UIKit

class ArrowView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.clear
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.backgroundColor = UIColor.clear
  }
  
  override func draw(_ rect: CGRect) {
    // 화살표의 중심 좌표 계산하기
    let topCenter = CGPoint(x: bounds.width / 2, y: bounds.height)
    
    // 화살표 그리기
    let arrowPath = UIBezierPath()
    arrowPath.move(to: topCenter)
    arrowPath.addLine(to: CGPoint(x: topCenter.x + 10, y: topCenter.y - 30))
    arrowPath.addLine(to: CGPoint(x: topCenter.x - 10, y: topCenter.y - 30))
    arrowPath.close()
    UIColor.red.setFill()
    arrowPath.fill()
  }
}

