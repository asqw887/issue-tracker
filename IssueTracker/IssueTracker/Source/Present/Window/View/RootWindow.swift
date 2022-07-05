//
//  RootWindow.swift
//  IssueTracker
//
//  Created by 최예주 on 2022/06/23.
//

import Foundation
import UIKit

final class RootWindow: UIWindow {

    let rootWindowViewModel = RootWindowViewModel()

    init(scene: UIWindowScene) {
        super.init(windowScene: scene)
        overrideUserInterfaceStyle = .light
        rootWindowViewModel.requestLoginStatus()
        bind()
    }

    private func bind() {
        rootWindowViewModel.isValidLogin.bind { [unowned self] answer in
            if answer {
                DispatchQueue.main.async {
                    let tabBarVC = TabBarViewController()
                    self.rootViewController = tabBarVC
                    return
                }
            } else {
                DispatchQueue.main.async {
                    self.rootViewController = LoginViewController(viewModel: LoginViewModel(repository: LoginRepository()))
                    return
                }
            }
        }
    }

    func setIssueListVC() {
        DispatchQueue.main.async {
            let issueListVC = IssueListViewController(viewModel: IssueListViewModel())
            issueListVC.viewModel.loadIssueList()
            self.rootViewController = TabBarViewController()
            return
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
