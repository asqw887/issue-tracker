//
//  FilterCell.swift
//  IssueTracker
//
//  Created by 최예주 on 2022/06/30.
//

import UIKit
import SnapKit

class FilterCell: UITableViewCell {

    static let reuseIdentifier = "FilterCell"

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        setLayouts()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // 이미 선택된 상태인지 확인해야함

    }

    func setComponents(with title: String) {
        self.titleLabel.text = title
    }

}

private extension FilterCell {
    func setLayouts() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(11)
            make.bottom.equalTo(contentView.snp.bottom).offset(-11)
            make.left.equalTo(contentView.snp.left).offset(20)
            make.height.equalTo(22)
        }
    }
}
