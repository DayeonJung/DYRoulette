//
//  CompleteRotateViewController.swift
//  roulette
//
//  Created by Dayeon Jung on 2023/03/05.
//

import Foundation
import UIKit
import Lottie
import RxSwift

class CompleteRotateViewController: UIViewController {
  var disposeBag = DisposeBag()
  
  var message: String!
  
  var animationView = AnimationView(name: "present")
  var closeButton = UIButton()
  
  lazy var label = UILabel().then {
    $0.text = self.message
    $0.font = .systemFont(ofSize: 44, weight: .bold)
    $0.textColor = .black
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
 
    view.backgroundColor = .white
    animationView.play() // 애미메이션뷰 실행
    
    setupLayout()
    bind()
  }
  
  private func setupLayout() {
    view.addSubview(animationView) // 애니메이션뷰를 메인뷰에 추가
    animationView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.centerY.equalToSuperview().offset(80)
      $0.width.equalToSuperview()
    }
    
    view.addSubview(label)
    label.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.centerY.equalToSuperview().offset(-80)
    }
    
    view.addSubview(closeButton)
    closeButton.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  private func bind() {
    closeButton.rx.tap
      .withUnretained(self)
      .bind { owner, _ in
        owner.dismiss(animated: true, completion: nil)
      }
      .disposed(by: disposeBag)
  }
}
