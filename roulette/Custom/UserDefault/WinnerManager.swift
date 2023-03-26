//
//  WinnerManager.swift
//  roulette
//
//  Created by Dayeon Jung on 2023/03/26.
//

import Foundation

class WinnerUD {
  @UserDefault(key: UserDefaultKeys.winnerID.rawValue, defaultValue: Data())
  static private var _id: Data
  
  static var id: UUID {
    get {
      var uuid = UUID()
      if let str = String(data: _id, encoding: .utf8) {
        if let uuidFromData = UUID(uuidString: str) {
          uuid = uuidFromData
        }
      }
      return uuid
    }
    set {
      WinnerUD._id = newValue.uuidString.data(using: .utf8) ?? Data()
    }
  }
  
  @CodableUserDefault(
    key: UserDefaultKeys.candidateList.rawValue,
    defaultValue: CandidateList(list: [Candidate(id: WinnerUD.id, realName: "김오름", nickName: "오름이")])
  )
  static var candidateList: CandidateList
  
  static func name() -> String? {
    return candidateList.list.filter { $0.id == id }.first?.realName
  }
  
  static func nickName() -> String? {
    return candidateList.list.filter { $0.id == id }.first?.nickName
  }
  
  static func candidatesName() -> [String] {
    return candidateList.list.map { $0.displaySimply() }
  }
  
  static func addCandidate(item: Candidate) {
    var currentList = candidateList.list
    currentList.append(item)
    WinnerUD.candidateList = CandidateList(list: currentList)
  }
  
  static func setCandidates(list: CandidateList) {
    WinnerUD.candidateList = list
  }
 }

