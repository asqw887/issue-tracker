//
//  IssueCellViewModel.swift
//  IssueTracker
//
//  Created by 최예주 on 2022/06/29.
//

import Foundation

final class IssueCellViewModel {

    let issue: Issue

    init(issue: Issue) {
        self.issue = issue
    }

    var title: String {
        return issue.title
    }
    var description: String {
        return issue.description ?? ""
    }
    var tag: String {
        // TODO: CellView에서 태그가 여러개 나올 수 있도록 기능 구현 후, 배열 전체를 반환하도록 변경
        guard let title = issue.tag?.first?.title else { return "" }
        return title
    }
    var milestone: String {
        guard let title = issue.milestone?.title else { return "🪧"}
        return "🪧\(title)"
    }

}
