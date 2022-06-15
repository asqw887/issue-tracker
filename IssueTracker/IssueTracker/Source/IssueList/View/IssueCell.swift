//
//  IssueCell.swift
//  IssueTracker
//
//  Created by 최예주 on 2022/06/14.
//

import UIKit
import SnapKit

class IssueCell: UICollectionViewCell {

    static let reuseIdentifier = "IssueCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        addsubviews()
        setLayouts()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()

    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "이슈에 대한 설명(최대 두줄 까지 보여줄 수 있다)"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 17)
        return label
    }()

    private var milestoneLabel: UILabel = {
        let label = UILabel()
        label.text = "마일스톤 이름"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 17)
        return label
    }()

    private var tagLabel: UILabel = {
        let label = UILabel()
        label.text = "레이블 이름"
        label.backgroundColor = .systemGray2
        label.textColor = .white
        label.font = .systemFont(ofSize: 17)
        label.clipsToBounds = true
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        return label
    }()

    private func addsubviews() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(milestoneLabel)
        self.contentView.addSubview(tagLabel)
    }

    private func setLayouts() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(24)
            make.left.trailing.equalTo(contentView).offset(16)
            make.height.equalTo(28)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.trailing.equalTo(titleLabel)
            make.height.equalTo(28)
        }

        milestoneLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.left.trailing.equalTo(titleLabel)
            make.height.equalTo(22)
        }

        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(milestoneLabel.snp.bottom).offset(16)
            make.left.equalTo(titleLabel)
            make.height.equalTo(22)
            make.width.greaterThanOrEqualTo(114)
            make.bottom.equalTo(contentView.snp.bottom).offset(-24)
        }
    }

}
