//
//  Tag.swift
//  IssueTracker
//
//  Created by 최예주 on 2022/06/14.
//

import Foundation

final class Tag: Inform {

    let backgroundColor: String

    init(title: String, backgroundColor: String) {
        self.backgroundColor = backgroundColor
        super.init(title: title)
    }

}
