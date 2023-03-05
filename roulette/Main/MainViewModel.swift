//
//  MainViewModel.swift
//  roulette
//
//  Created by Dayeon Jung on 2023/03/05.
//

import Foundation
import RxRelay

class MainViewModel {
  // 룰렛에 표시될 텍스트들
  @UserDefault(key: UserDefaultKeys.rouletteItems.rawValue, defaultValue: ["미니상품 1개", "미니상품 2개", "대박상품"])
  var items: [String]
  
  // 선택된 룰렛의 인덱스
  var selectedIndex: Int = 1

  init() {
    
  }
}
