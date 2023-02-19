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
    $0.spacing = 8
  }
  
  // 추첨하기 버튼
  var button = UIButton().then {
    $0.backgroundColor = .lightGray
    $0.layer.borderColor = UIColor.gray.cgColor
    $0.layer.borderWidth = 1
    $0.layer.cornerRadius = 8
    $0.clipsToBounds = true
    $0.setTitle("추첨하기", for: .normal)
    $0.setTitleColor(.black, for: .normal)
  }
  
  // 편집하기 버튼
  var editButton = UIButton().then {
    $0.backgroundColor = .lightGray
    $0.layer.borderColor = UIColor.gray.cgColor
    $0.layer.borderWidth = 1
    $0.layer.cornerRadius = 8
    $0.clipsToBounds = true
    $0.setTitle("추가/삭제", for: .normal)
    $0.setTitleColor(.black, for: .normal)
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
    
    stackView.addArrangedSubview(button)
    stackView.addArrangedSubview(editButton)
    
    [button, editButton].forEach {
      $0.snp.makeConstraints {
        $0.width.equalTo(88)
      }
    }
  }

}

