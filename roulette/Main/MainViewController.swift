//
//  MainViewController.swift
//  roulette
//
//  Created by Dayeon Jung on 2023/02/19.
//

import Foundation
import UIKit
import SnapKit
import Then

import RxSwift
import RxCocoa

class MainViewController: UIViewController {
  var disposeBag = DisposeBag()
  
  // 화살표 뷰
  var arrowImageView = UIImageView().then {
    $0.image = UIImage(named: "arrowDown")?.withRenderingMode(.alwaysTemplate)
    $0.tintColor = .white
    $0.layer.shadowColor = UIColor.black.cgColor // 그림자 색상
    $0.layer.shadowOpacity = 0.5 // 그림자 투명도
    $0.layer.shadowOffset = CGSize(width: 0, height: 3) // 그림자 위치
    $0.layer.shadowRadius = 5 // 그림자 크기
    $0.snp.makeConstraints {
      $0.size.equalTo(48)
    }
  }
  
  var headerView: HeaderView!
  
  // 룰렛 뷰
  var rouletteView: RouletteView!
  
  // 설정 뷰
  var settingView: SettingView!
  
  // 설명 뷰
  var descriptionView: DescriptionView!
  
  var viewModel = MainViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setUI()
    bind()
  }

  private func setUI() {
    headerView = HeaderView(frame: .zero)
    view.addSubview(headerView)
    headerView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(56)
      $0.leading.trailing.equalToSuperview()
    }
    
    rouletteView = RouletteView(textArray: viewModel.items)
    view.addSubview(rouletteView)
    rouletteView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.height.equalTo(rouletteView.snp.width)
      $0.centerY.equalToSuperview().offset(20)
    }
    
    view.addSubview(arrowImageView)
    arrowImageView.snp.makeConstraints {
      $0.bottom.equalTo(rouletteView.snp.top).offset(12)
      $0.centerX.equalTo(rouletteView)
    }
    
    descriptionView = DescriptionView()
    view.addSubview(descriptionView)
    descriptionView.snp.makeConstraints {
      $0.bottom.equalToSuperview().offset(-20)
      $0.centerX.equalToSuperview()
    }
    
    settingView = SettingView()
    view.addSubview(settingView)
    settingView.snp.makeConstraints {
      $0.bottom.equalTo(descriptionView.snp.top).offset(-28)
      $0.centerX.equalToSuperview()
    }
  }
  
  private func bind() {
    // 룰렛을 돌리는 버튼 액션 함수
    settingView.button.rx.tap
      .withUnretained(self)
      .bind { owner, _ in
        // 룰렛을 돌리는 애니메이션 실행
        let randomAngle = owner.randomAngle()
        let oneArcAngle = owner.rouletteView.oneArcAngle
        owner.viewModel.selectedIndex = Int(floor(randomAngle/oneArcAngle))
        owner.rouletteView.runSpinAnimation(spinAmount: randomAngle)

        // 룰렛이 선택된 결과를 출력
        DispatchQueue.main.asyncAfter(deadline: .now() + owner.rouletteView.spinDuration + 0.5) { [weak self] in
          guard let self = self else { return }
          
          let vc = CompleteRotateViewController()
          vc.message = "\(self.viewModel.items[self.viewModel.selectedIndex])"
          vc.modalPresentationStyle = .fullScreen
          self.present(vc, animated: true, completion: nil)
        }
      }
      .disposed(by: disposeBag)
    
    settingView.editButton.rx.tap
      .withUnretained(self)
      .bind { owner, _ in
        let vc = EditViewController()
        let viewModel = EditViewModel(items: owner.viewModel.items)
        vc.viewModel = viewModel
        
        vc.confirmButton.rx.tap
          .withUnretained(owner)
          .bind { owner, _ in
            vc.dismiss(animated: true) {
              owner.viewModel.items = viewModel.items
              owner.rouletteView.changeTexts(to: viewModel.items)
            }
          }
          .disposed(by: owner.disposeBag)
        owner.present(vc, animated: true, completion: nil)
      }
      .disposed(by: disposeBag)
  }

  // 룰렛 회전량을 결정하는 함수
  func randomAngle() -> CGFloat {
    // 랜덤으로 인덱스 선택
    return Double.random(in: 0...2 * .pi)
  }
}
