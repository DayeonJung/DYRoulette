//
//  RouletteView.swift
//  roulette
//
//  Created by Dayeon Jung on 2023/02/19.
//

import UIKit

class RouletteView: UIView {
  var texts: [String] = []
  var labels: [UILabel] = []
  var roulettePath: UIBezierPath?
  
  // 애니메이션 상수
  let spinDuration: TimeInterval = 3.0
  let spinRotateCount: CGFloat = 3.0
    
  var oneArcAngle: CGFloat {
    CGFloat.pi * 2.0 / CGFloat(texts.count)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.clear
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.backgroundColor = UIColor.clear
  }
  
  convenience init(textArray: [String]) {
    self.init(frame: .zero)
    texts = textArray
  }
  
  override func draw(_ rect: CGRect) {
    let width = rect.width
    let height = rect.height
    let center = CGPoint(x: width / 2, y: height / 2)
    let radius = min(width, height) / 2 - 1
    
    // 룰렛에 표시될 숫자 그리기
    let labelFont = UIFont.systemFont(ofSize: 20.0, weight: .bold)
    let labelColor = UIColor.black
    
    // UIBezierPath와 레이블 초기화
    roulettePath = nil
    labels.forEach { $0.removeFromSuperview() }
    labels.removeAll()
    
    for i in 0..<texts.count {
      let startAngle = oneArcAngle * CGFloat(i) - CGFloat.pi / 2.0
      let endAngle = oneArcAngle * CGFloat(i + 1) - CGFloat.pi / 2.0
      
      
      // 룰렛의 각 호에 색 칠하기
      let path = UIBezierPath()
      path.move(to: center)
      path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
      path.close()

      let fillColor = UIColor(hue: CGFloat(i) / CGFloat(texts.count), saturation: 0.5, brightness: 1.0, alpha: 1.0)
      fillColor.setFill()
      path.fill()
      
      if roulettePath == nil {
        roulettePath = path // 최초의 path는 그대로 저장
      } else {
        roulettePath?.append(path) // 이후 path는 append 해줌
      }
      
      // 룰렛에 표시될 숫자 레이블 그리기
      let labelAngle = (startAngle + endAngle) / 2.0
      let labelCenterX = center.x + cos(labelAngle) * radius * 0.55
      let labelCenterY = center.y + sin(labelAngle) * radius * 0.55

      let label = UILabel(frame: CGRect(x: 0, y: 0, width: radius * 0.9, height: 40))
      label.autoScale()
      label.text = texts[i]
      label.font = labelFont
      label.textColor = labelColor
      label.textAlignment = .center
      label.center = CGPoint(x: labelCenterX, y: labelCenterY)
      
      let dx = label.center.x - center.x
      let dy = label.center.y - center.y
      let labelAngleRadians = atan2(dy, dx)
      label.transform = CGAffineTransform(rotationAngle: labelAngleRadians)
      
      self.addSubview(label)
    }
  }
  
  // 룰렛 애니메이션 실행 함수
  func runSpinAnimation(spinAmount: CGFloat) {
    let spinAnimation = CABasicAnimation(keyPath: "transform.rotation")
    spinAnimation.fromValue = 0.0
    spinAnimation.toValue = CGFloat.pi * 2.0 * spinRotateCount - spinAmount
    spinAnimation.duration = spinDuration
    spinAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
    spinAnimation.fillMode = .forwards
    spinAnimation.isRemovedOnCompletion = false
    layer.add(spinAnimation, forKey: "spinAnimation")
  }

  func changeTexts(to items: [String]) {
    texts = items
    reset()
    setNeedsDisplay()
  }
  
  // RouletteView의 subviews에서 UIBezierPath와 UILabel을 찾아 삭제합니다.
  private func reset() {
    for subview in subviews {
      if let label = subview as? UILabel {
        label.removeFromSuperview()
      }
      if let layer = subview.layer as? CAShapeLayer, layer.path != nil {
        layer.path = nil
        layer.removeFromSuperlayer()
      }
    }
  }
}

