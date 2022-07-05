//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by 최예주 on 2022/06/14.
//

import UIKit
import SnapKit

final class IssueListViewController: UIViewController {

    var viewModel: IssueListViewModel

    init(viewModel: IssueListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.register(IssueCell.self, forCellReuseIdentifier: IssueCell.self.reuseIdentifier)
        return tableView
    }()

    private lazy var filterButton: UIBarButtonItem = {
        let button = UIButton()
        button.setImage(UIImage(named: "filterIcon"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        button.setTitle("필터", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(filterButtonPressed(_:)), for: .touchUpInside)

        let barbutton = UIBarButtonItem(customView: button)
        return barbutton
    }()

    private lazy var selectButton: UIBarButtonItem = {
        let button = UIButton()
        button.setTitle("선택", for: .normal)
        button.setImage(UIImage(named: "selectIcon"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(selectButtonPressed(_:)), for: .touchUpInside)

        let barbutton = UIBarButtonItem(customView: button)
        return barbutton
    }()

    private lazy var cancelButton: UIBarButtonItem = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(cancelButtonPressed(_:)), for: .touchUpInside)

        let barbutton = UIBarButtonItem(customView: button)
        return barbutton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        setLayout()
        setNavigationController()
        bind()
    }

    private func setLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func bind() {
        viewModel.issueList.bind { [unowned self] _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    private func setNavigationController() {
        self.navigationItem.setLeftBarButton(filterButton, animated: true)
        self.navigationItem.setRightBarButton(selectButton, animated: true)
    }

    @objc func filterButtonPressed(_ sender: Any) {
        // TODO: filter Modal present
    }

    @objc func selectButtonPressed(_ sender: UIBarButtonItem!) {
        // TODO: select Issue Logic
        tableView.allowsMultipleSelection = true
        tableView.allowsSelectionDuringEditing = true
        DispatchQueue.main.async { [unowned self] in
            self.navigationItem.setRightBarButton(cancelButton, animated: false)
        }
    }

    // TODO: - 취소 버튼을 누르면 어떤일이 실행되어야 할까?
    /// 1. 하단에 반응형으로 나타나던 뷰가 사라짐
    /// 2. 모든 셀들의 selected 상태가 false 로 변경됨
    /// 2-1. VC 에서 모든 cell 을 보는 방법
    /// 2-2.  checkBox.isHidden = true 를 전달할 방법 모색
    ///     셀 그리기 작업에서 체크박스를 다뤄야하 하는 것은 아닐까?
    /// 3. 오른쪽 네비게이션 아이템을 선택으로 변경
    /// 4. 테이블 뷰의 셀렉트 기능을 끔
    @objc func cancelButtonPressed(_ sender: Any) {
        tableView.allowsMultipleSelection = false
        tableView.allowsSelectionDuringEditing = false
        DispatchQueue.main.async { [unowned self] in
            self.navigationItem.setRightBarButton(selectButton, animated: false)
            self.tableView.reloadData()
        }
    }
}

extension IssueListViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - 보여질 셀 갯수 설정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection
    }
    // MARK: - Datasource 설정
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: IssueCell.self.reuseIdentifier,
            for: indexPath) as? IssueCell
        else { return UITableViewCell() }

        let issueItem = viewModel.issueList.value[indexPath.row]
        let cellViewModel = IssueCellViewModel(issue: issueItem)
        cell.setComponenets(with: cellViewModel)
        cell.isSelected = false
        return cell
    }

    // MARK: - 좌 스와이프
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let issueDelete = UIContextualAction(style: .destructive, title: "삭제") {
            (_, _, success: @escaping (Bool) -> Void) in
            success(true)
        }
        issueDelete.backgroundColor = .systemPink
        issueDelete.image = UIImage(systemName: "trash")

        let issueClose = UIContextualAction(style: .normal, title: "닫기") {
            (_, _, success: @escaping (Bool) -> Void) in
            success(true)
        }
        issueClose.backgroundColor = .systemBlue
        issueClose.image = UIImage(systemName: "archivebox")

        // MARK: - trailingSwipe라서 0번 째 부터 가장 오른쪽에 위치함
        /// UI 로 보이는 순서 :: 삭제, 닫기
        return UISwipeActionsConfiguration(actions: [issueClose, issueDelete])
    }

    // TODO: - 테이블 뷰에서 최상단에 도달 했을 때 서치바 보이게 하기
    //    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
    //    }
}
