//
//  DescriptionView.swift
//  roulette
//
//  Created by Dayeon Jung on 2023/03/26.
//

import UIKit

class DescriptionView: UIView {
  var stackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 8
  }
  
  var descriptionLabel = UILabel().then {
    $0.text = "OO를 위해"
    $0.font = .boldSystemFont(ofSize: 20)
    $0.textAlignment = .center
    $0.textColor = .white
  }
  
  var subDescriptionLabel = UILabel().then {
    $0.text = "완북도 하고~ 숙제도 잘해오고~ 지각도 없고~\n한달동안 수고했어 선생님이 쏜다!!~"
    $0.numberOfLines = 0
    $0.font = .systemFont(ofSize: 20, weight: .regular)
    $0.textAlignment = .center
    $0.textColor = .white
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
    
    [descriptionLabel, subDescriptionLabel]
      .forEach {
        stackView.addArrangedSubview($0)
      }
  }
}

