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
        stackView.spacing = 16
        return stackView
    }()

    private let cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        return stackView
    }()

    private func addsubviews() {
        [titleLabel, descriptionLabel, milestoneLabel, tagLabel].forEach { [unowned self] in
            self.descriptionStackView.addArrangedSubview($0)
        }
        [descriptionStackView, checkboxImageView].forEach { [unowned self] in
            self.cellStackView.addArrangedSubview($0)
        }
        self.contentView.addSubview(cellStackView)
    }

    private func attributes() {
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.checkboxImageView.isHidden = false
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
