//
//  Milestone.swift
//  IssueTracker
//
//  Created by 최예주 on 2022/06/14.
//

import Foundation

final class Milestone: Inform {

    let completeDay: Date?

    init(title: String, completeDay: Date? = nil) {
        self.completeDay = completeDay
        super.init(title: title)
    }
}
