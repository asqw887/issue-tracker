//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by 최예주 on 2022/06/14.
//

import UIKit
import SnapKit
import SwipeCellKit

class IssueListViewController: UIViewController {

    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(IssueCell.self, forCellWithReuseIdentifier: IssueCell.reuseIdentifier)
        return collectionView
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
        collectionView.dataSource = self
        collectionView.delegate = self
        self.view.addSubview(collectionView)
        setLayout()
        setNavigationController()
        setAttribute()

    }

    private func setAttribute() {
        self.view.backgroundColor = .red
    }

    private func setLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setNavigationController() {
        self.navigationItem.setLeftBarButton(filterButton, animated: true)
        self.navigationItem.setRightBarButton(selectButton, animated: true)
    }

    @objc private func filterButtonPressed(_ sender: Any) {
        // TODO: filter Modal present
    }

    @objc private func selectButtonPressed(_ sender: Any) {
        // TODO: select Issue Logic
    }
}

extension IssueListViewController: UICollectionViewDelegate, UICollectionViewDataSource, SwipeCollectionViewCellDelegate {
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "삭제") { action, indexPath in
            //TODO: - 이슈 삭제 로직 추가
        }
        
        let issueCloseAction = SwipeAction(style: .default, title: "닫기") { Action, indexPath in
            //TODO: - 이슈 닫기 기능 추가
        }

        
        deleteAction.image = UIImage(named: "delete")
        issueCloseAction.image = UIImage(named: ")
        return [deleteAction]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: IssueCell.reuseIdentifier,
                                     for: indexPath)
                as? SwipeCollectionViewCell
        else { return SwipeCollectionViewCell() }
        cell.delegate = self
        return cell
    }

}

extension IssueListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width, height: 199)
        return size
    }
}
