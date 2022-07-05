//
//  FilterViewModel.swift
//  IssueTracker
//
//  Created by 최예주 on 2022/06/30.
//

import Foundation

final class FilterViewModel {

    enum Section: Int {
        case state = 0
        case author
        case label

        var value: String {
            switch self {
            case .state:
                return "상태"
            case .author:
                return "작성자"
            case .label:
                return "레이블"
            }
        }
    }

    let stateSection = ["열린 이슈", "내가 작성한 이슈", "나에게 할당된 이슈", "내가 댓글을 남긴 이슈", "닫힌 이슈"]

}
