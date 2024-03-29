//
//  SettingView.swift
//  roulette
//
//  Created by Dayeon Jung on 2023/02/19.
//

import UIKit

class SettingView: UIView {
  var stackView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = 20
  }
  
  // 추첨하기 버튼
  var button = UIButton().then {
    $0.backgroundColor = .clear
    $0.setImage(UIImage(named: "play"), for: .normal)
  }
  
  // 편집하기 버튼
  var editButton = UIButton().then {
    $0.backgroundColor = .clear
    let coloredImage = UIImage(named: "edit")?.withTintColor(.white, renderingMode: .alwaysOriginal)
    $0.setImage(coloredImage, for: .normal)
 }
  
  // 당첨 기록 보기 버튼
  var historyButton = UIButton().then {
    $0.backgroundColor = .clear
    let coloredImage = UIImage(named: "clock")
    $0.setImage(coloredImage, for: .normal)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.clear
    
    setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.backgroundColor = UIColor.clear
  }
  
  private func setupUI() {
    addSubview(stackView)
    stackView.snp.makeConstraints {
      $0.edges.equalToSuperview()
      $0.height.equalTo(48)
    }
    
    [button, editButton, historyButton].forEach {
      stackView.addArrangedSubview($0)
      $0.snp.makeConstraints {
        $0.width.equalTo(48)
      }
    }
  }

}

