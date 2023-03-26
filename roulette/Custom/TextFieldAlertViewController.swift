//
//  TextFieldAlertViewController.swift
//  roulette
//
//  Created by Dayeon Jung on 2023/03/05.
//

import Foundation
import UIKit
import RxRelay
/*
 let alertController = UIAlertController(title: "Enter text", message: nil, preferredStyle: .alert)
 
 alertController.addTextField { (textField) in
 textField.placeholder = "Enter text here"
 }
 
 let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
 let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] (action) in
 guard let textField = alertController.textFields?.first else { return }
 guard let text = textField.text else { return }
 // 텍스트 필드에 입력된 텍스트를 처리하는 코드 작성
 print("Entered text: \(text)")
 }
 
 alertController.addAction(cancelAction)
 alertController.addAction(okAction)
 
 present(alertController, animated: true, completion: nil)
 */

class TextFieldAlertViewController: UIAlertController {
  var placeHolderTexts: [String] = []
  var complete: PublishRelay<[String]> = .init()
  
  convenience init(title: String?, message: String?, preferredStyle: UIAlertController.Style, placeHolderTexts: [String]) {
    self.init(title: title, message: message, preferredStyle: preferredStyle)
    self.placeHolderTexts = placeHolderTexts
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addTextField()
  }
  
  private func addTextField() {
    _ = self.placeHolderTexts.map { placeHolder in
      addTextField { $0.placeholder = placeHolder }
    }
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] (action) in
      guard let self = self else { return }
      guard let textFields = self.textFields else { return }
      
      self.complete.accept(textFields.compactMap { $0.text })
    }
    
    addAction(cancelAction)
    addAction(okAction)
  }
}
