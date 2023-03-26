//
//  ManageCandidateViewModel.swift
//  roulette
//
//  Created by Dayeon Jung on 2023/03/26.
//

import Foundation
import RxSwift
import RxRelay

class ManageCandidateViewModel {
  var disposeBag = DisposeBag()
  var candidates: CandidateList
  var items: [String]
  var winnerSelected: PublishRelay<Void> = .init()
  
  init() {
    self.candidates = WinnerUD.candidateList
    self.items = WinnerUD.candidatesName()
  }
  
  func addItem(texts: [String]) {
    // UserDefaults에 저장
    let item = Candidate(
      id: UUID(),
      realName: texts.first ?? "",
      nickName: texts.last ?? ""
    )
    WinnerUD.addCandidate(item: item)
    
    // 모델 업데이트
    candidates.list.append(item)
    items.append(item.displaySimply())
  }
  
  func moveItem(fromIndex: Int, toIndex: Int) {
    let movedItem = items[fromIndex]
    items.remove(at: fromIndex)
    items.insert(movedItem, at: toIndex)

    let candidateList = candidates.list
    let movedCandidate = candidateList[fromIndex]
    candidates.list.remove(at: fromIndex)
    candidates.list.insert(movedCandidate, at: toIndex)
  }
  
  func deleteRow(at index: Int) {
    items.remove(at: index)
    candidates.list.remove(at: index)
  }
}

