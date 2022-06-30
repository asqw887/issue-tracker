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
        viewModel.issueList.bind { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    private func setNavigationController() {
        self.navigationItem.setLeftBarButton(filterButton, animated: true)
        self.navigationItem.setRightBarButton(selectButton, animated: true)
    }

    @objc private func filterButtonPressed(_ sender: Any) {
        self.navigationController?.pushViewController(FilterViewController(), animated: true)
    }

    @objc private func selectButtonPressed(_ sender: Any) {
        // TODO: select Issue Logic
    }
}

extension IssueListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: IssueCell.self.reuseIdentifier,
            for: indexPath) as? IssueCell
        else { return UITableViewCell() }
        
        let issueItem = viewModel.issueList.value[indexPath.row]
        let cellViewModel = IssueCellViewModel(issue: issueItem)
        cell.setComponenets(with: cellViewModel)
       
        return cell
    }
}
