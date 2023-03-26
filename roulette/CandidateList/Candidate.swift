//
//  Candidate.swift
//  roulette
//
//  Created by Dayeon Jung on 2023/03/26.
//

import Foundation

struct Candidate: Codable {
  var id: UUID
  var realName: String
  var nickName: String
  
  func displaySimply() -> String {
    "\(realName)/\(nickName)"
  }
}

struct CandidateList: Codable {
  var list: [Candidate]
}
