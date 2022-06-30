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
    let issueListViewModel = IssueListViewModel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addsubviews()
        setLayouts()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.font = .boldSystemFont(ofSize: 22)
        label.numberOfLines = 1
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "이슈에 대한 설명(최대 두줄 까지 보여줄 수 있다)"
        label.numberOfLines = 2
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 17)
        label.sizeToFit()
        return label
    }()

    let milestoneLabel: UILabel = {
        let label = UILabel()
        label.text = "마일스톤 이름"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 17)
        return label
    }()

    let tagLabel: UILabel = {
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

    let cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 16
        return stackView
    }()

    private func addsubviews() {
        [titleLabel, descriptionLabel, milestoneLabel, tagLabel].forEach { [unowned self] view in
            self.cellStackView.addArrangedSubview(view)
        }
        self.contentView.addSubview(cellStackView)
    }

    private func setLayouts() {
        cellStackView.snp.makeConstraints {
            $0.edges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
    }

    func setComponenets(with viewModel: IssueCellViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        tagLabel.text = viewModel.tag
        milestoneLabel.text = viewModel.milestone
    }

}
