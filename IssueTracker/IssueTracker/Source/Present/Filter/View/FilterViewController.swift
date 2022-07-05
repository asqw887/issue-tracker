//
//  FilterViewController.swift
//  IssueTracker
//
//  Created by 최예주 on 2022/06/30.
//

import UIKit

class FilterViewController: UIViewController {

    private let filterViewModel = FilterViewModel()

    private lazy var filteringButton: UIBarButtonItem = {
            let button = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(filteringButtonPressed(_:)))
            return button
        }()

    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FilterCell.self, forCellReuseIdentifier: FilterCell.reuseIdentifier)

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationController()
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        setLayout()
    }

    private func setNavigationController() {
        self.navigationItem.title = "필터"
        self.navigationItem.setRightBarButton(filteringButton, animated: true)
    }

    @objc
    private func filteringButtonPressed(_ sender: UIBarButtonItem) {
        // pop & 필터 적용
    }

    private func setLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.view)
        }
    }

}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case FilterViewModel.Section.state.rawValue:
            return 5
        case 1:
            return 0
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case FilterViewModel.Section.state.rawValue:
            return FilterViewModel.Section.state.value
        case 1:
            return "작성자"
        default:
            return "레이블"
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterCell.reuseIdentifier, for: indexPath) as? FilterCell else { return UITableViewCell() }
        cell.setComponents(with: filterViewModel.stateSection[indexPath.row])
        return cell

    }

}
