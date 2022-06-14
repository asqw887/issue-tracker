//
//  Inform.swift
//  IssueTracker
//
//  Created by 최예주 on 2022/06/14.
//

import Foundation

class Inform {
    let title: String
    let description: String?

    init(title: String, description: String? = nil) {
        self.title = title
        self.description = description
    }
}
