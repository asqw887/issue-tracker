//
//  IssueCell.swift
//  IssueTracker
//
//  Created by 최예주 on 2022/06/14.
//

import UIKit
import SnapKit

final class IssueCell: UITableViewCell {

    static let reuseIdentifier = "IssueCell"
    var issueListViewModel = IssueListViewModel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addsubviews()
        setLayouts()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }

    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()

    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "이슈에 대한 설명(최대 두줄 까지 보여줄 수 있다)"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 17)
        return label
    }()

    var milestoneLabel: UILabel = {
        let label = UILabel()
        label.text = "마일스톤 이름"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 17)
        return label
    }()

    var tagLabel: UILabel = {
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

    func setComponenets(with viewModel: IssueCellViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        tagLabel.text = viewModel.tag
        milestoneLabel.text = viewModel.milestone
    }

}
