//
//  EditViewController.swift
//  roulette
//
//  Created by Dayeon Jung on 2023/03/05.
//

import UIKit

class EditViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  var titleLabel = UILabel().then {
    $0.text = "편집"
    $0.font = .systemFont(ofSize: 20, weight: .bold)
    $0.textColor = .black
  }
  
  var tableView = UITableView().then {
    $0.register(EditItemCell.self, forCellReuseIdentifier: "EditItemCell")
  }
  
  var confirmButton = UIButton().then {
    $0.setTitle("적용", for: .normal)
    $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
    $0.setTitleColor(.white, for: .normal)
    $0.layer.cornerRadius = 12
    $0.clipsToBounds = true
    $0.backgroundColor = UIColor(red: 78.0/255.0, green: 0.0, blue: 167.0/255.0, alpha: 1.0)
  }
  
  var items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .white
    
    
    self.view.addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(24)
      $0.leading.equalToSuperview().offset(20)
    }
    
    self.view.addSubview(confirmButton)
    confirmButton.snp.makeConstraints {
      $0.bottom.equalToSuperview().offset(-20)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.height.equalTo(48)
    }
    
    self.view.addSubview(tableView)
    tableView.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(12)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(confirmButton.snp.top)
    }
    
    // UITableView 설정
    tableView.dataSource = self
    tableView.delegate = self
    tableView.isEditing = true
  }
  
  // MARK: - UITableViewDataSource
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "EditItemCell", for: indexPath)
    cell.textLabel?.text = items[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let movedItem = items[sourceIndexPath.row]
    items.remove(at: sourceIndexPath.row)
    items.insert(movedItem, at: destinationIndexPath.row)
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      items.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  // MARK: - UITableViewDelegate
  
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .delete
  }
}
