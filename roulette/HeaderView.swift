//
//  HeaderView.swift
//  roulette
//
//  Created by Dayeon Jung on 2023/02/19.
//

import UIKit

class HeaderView: UIView {
  var stackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 8
  }
  
  let topLabel = UILabel().then {
    $0.text = "오름수학 룰렛데이"
    $0.font = .boldSystemFont(ofSize: 20)
    $0.textAlignment = .center
    $0.textColor = .white
  }
  
  let subTitleLabel = UILabel().then {
    $0.text = "칭찬점수 30점 넘은 사람"
    $0.font = .boldSystemFont(ofSize: 32)
    $0.textAlignment = .center
    $0.textColor = .white
  }
  
  let titleLabel = UILabel().then {
    $0.text = "여기여기 모여라♥"
    $0.font = .boldSystemFont(ofSize: 40)
    $0.textColor = .yellow
    $0.textAlignment = .center
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
    }
    
    [topLabel, subTitleLabel, titleLabel]
      .forEach {
        stackView.addArrangedSubview($0)
      }
    
    stackView.setCustomSpacing(30, after: topLabel)
  }
}

