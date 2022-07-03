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
        attributes()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }

    private let checkboxImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.font = .boldSystemFont(ofSize: 22)
        label.numberOfLines = 1
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "이슈에 대한 설명(최대 두줄 까지 보여줄 수 있다)"
        label.numberOfLines = 2
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 17)
        label.sizeToFit()
        return label
    }()

    private let milestoneLabel: UILabel = {
        let label = UILabel()
        label.text = "마일스톤 이름"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 17)
        return label
    }()

    private let tagLabel: UILabel = {
        let label = PaddingLabel()
        label.text = "레이블 이름"
        // TODO: issue.tag.color 로 변경 예정
        label.backgroundColor = .systemGray2
        label.textColor = .white
        label.font = .systemFont(ofSize: 17)
        label.clipsToBounds = true
        label.textAlignment = .center
        label.layer.cornerRadius = label.intrinsicContentSize.height / 2
        return label
    }()

    private let descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        return stackView
    }()

    private func addsubviews() {
        [descriptionLabel, milestoneLabel, tagLabel].forEach { [unowned self] in
            self.descriptionStackView.addArrangedSubview($0)
        }
        [titleLabel, checkboxImageView, descriptionStackView].forEach { [unowned self] in
            self.contentView.addSubview($0)
        }
    }

    private func attributes() {
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.checkboxImageView.isHidden = selected ? false : true

    }

    private func setLayouts() {

        titleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(16)
        }
        checkboxImageView.snp.makeConstraints {
            $0.top.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(16)
            $0.bottom.equalTo(titleLabel)
            $0.height.equalTo(checkboxImageView.snp.width)
        }
        descriptionStackView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
        }

    }

    func setComponenets(with viewModel: IssueCellViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        tagLabel.text = viewModel.tag
        milestoneLabel.text = viewModel.milestone
    }
}
