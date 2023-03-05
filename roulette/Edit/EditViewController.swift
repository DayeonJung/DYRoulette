//
//  EditViewController.swift
//  roulette
//
//  Created by Dayeon Jung on 2023/03/05.
//

import UIKit
import RxSwift

class EditViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  var disposeBag = DisposeBag()
  
  var titleLabel = UILabel().then {
    $0.text = "편집"
    $0.font = .systemFont(ofSize: 20, weight: .bold)
    $0.textColor = .black
  }
  
  var tableView = UITableView().then {
    $0.register(EditItemCell.self, forCellReuseIdentifier: "EditItemCell")
  }
  
  var addButton = UIButton().then {
    $0.setImage(UIImage(systemName: "plus"), for: .normal)
  }
  
  var confirmButton = UIButton().then {
    $0.setTitle("적용", for: .normal)
    $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
    $0.setTitleColor(.white, for: .normal)
    $0.layer.cornerRadius = 12
    $0.clipsToBounds = true
    $0.backgroundColor = UIColor(red: 78.0/255.0, green: 0.0, blue: 167.0/255.0, alpha: 1.0)
  }
  
  var viewModel: EditViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupLayout()
    setupUI()
    bind()
  }
  
  private func setupUI() {
    view.backgroundColor = .white
    
    // UITableView 설정
    tableView.dataSource = self
    tableView.delegate = self
    tableView.isEditing = true
  }
  
  private func setupLayout() {
    self.view.addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(24)
      $0.leading.equalToSuperview().offset(20)
    }
    
    self.view.addSubview(addButton)
    addButton.snp.makeConstraints {
      $0.size.equalTo(32)
      $0.centerY.equalTo(titleLabel)
      $0.trailing.equalToSuperview().offset(-20)
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
  }
  
  private func bind() {
    addButton.rx.tap
      .withUnretained(self)
      .bind { owner, _ in
        let alert = TextFieldAlertViewController(
          title: "룰렛을 추가해요",
          message: nil,
          preferredStyle: .alert,
          placeHolderTexts: "룰렛 항목을 입력하세요"
        )
        alert.complete
          .withUnretained(owner)
          .bind { owner, texts in
            owner.viewModel.addItem(text: texts)
            owner.tableView.reloadData()
          }
          .disposed(by: owner.disposeBag)
        owner.present(alert, animated: true, completion: nil)
      }
      .disposed(by: disposeBag)
  }
  
  // MARK: - UITableViewDataSource
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "EditItemCell", for: indexPath) as? EditItemCell else { return UITableViewCell() }
    cell.titleLabel.text = viewModel.items[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let movedItem = viewModel.items[sourceIndexPath.row]
    viewModel.items.remove(at: sourceIndexPath.row)
    viewModel.items.insert(movedItem, at: destinationIndexPath.row)
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      viewModel.items.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  // MARK: - UITableViewDelegate
  
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .delete
  }
}
