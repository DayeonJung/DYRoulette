//
//  EditItemCell.swift
//  roulette
//
//  Created by Dayeon Jung on 2023/03/05.
//
import UIKit

class EditItemCell: UITableViewCell {
  var titleLabel = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
    $0.translatesAutoresizingMaskIntoConstraints = false
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUI() {
    contentView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.top.leading.equalToSuperview().offset(16)
      $0.bottom.equalToSuperview().offset(-16)
    }

  }
}
