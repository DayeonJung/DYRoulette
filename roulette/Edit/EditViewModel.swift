//
//  EditViewModel.swift
//  roulette
//
//  Created by Dayeon Jung on 2023/03/05.
//

import Foundation

class EditViewModel {
  var items: [String]
  
  init(items: [String]) {
    self.items = items
  }
  
  func addItems(texts: [String]) {
    items.append(contentsOf: texts)
  }
}
