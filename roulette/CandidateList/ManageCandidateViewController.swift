//
//  ManageCandidateViewController.swift
//  roulette
//
//  Created by Dayeon Jung on 2023/03/26.
//

import UIKit
import RxSwift

class ManageCandidateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  var disposeBag = DisposeBag()
  
  var titleLabel = UILabel().then {
    $0.text = "당첨자를 선택해주세요"
    $0.font = .systemFont(ofSize: 20, weight: .bold)
    $0.textColor = .black
  }
  
  var tableView = UITableView().then {
    $0.register(EditItemCell.self, forCellReuseIdentifier: "EditItemCell")
  }
  
  var addButton = UIButton().then {
    $0.setImage(UIImage(systemName: "plus"), for: .normal)
  }
  
  var editButton = UIButton().then {
    $0.setImage(UIImage(systemName: "eraser.fill"), for: .normal)
  }
  
  var viewModel: ManageCandidateViewModel!
  
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
    
    self.view.addSubview(editButton)
    editButton.snp.makeConstraints {
      $0.size.equalTo(32)
      $0.centerY.equalTo(addButton)
      $0.trailing.equalTo(addButton.snp.leading).offset(-4)
    }
    
    self.view.addSubview(tableView)
    tableView.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(12)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  private func bind() {
    addButton.rx.tap
      .withUnretained(self)
      .bind { owner, _ in
        let alert = TextFieldAlertViewController(
          title: "당첨자 추가하기",
          message: nil,
          preferredStyle: .alert,
          placeHolderTexts: ["당첨자 이름을 입력하세요", "당첨자 애칭을 입력하세요"]
        )
        alert.complete
          .withUnretained(owner)
          .bind { owner, texts in
            owner.viewModel.addItem(texts: texts)
            owner.tableView.reloadData()
          }
          .disposed(by: owner.disposeBag)
        owner.present(alert, animated: true, completion: nil)
      }
      .disposed(by: disposeBag)
    
    editButton.rx.tap
      .withUnretained(self)
      .bind { owner, _ in
        owner.tableView.isEditing = !owner.tableView.isEditing
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
    viewModel.moveItem(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      viewModel.deleteRow(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  // MARK: - UITableViewDelegate
  
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .delete
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let candidate = viewModel.candidates.list[indexPath.row]
    WinnerUD.id = candidate.id
    dismiss(animated: true) { [weak self] in
      guard let self = self else { return}
      WinnerUD.setCandidates(list: self.viewModel.candidates)
      self.viewModel.winnerSelected.accept(())
    }
  }
}

