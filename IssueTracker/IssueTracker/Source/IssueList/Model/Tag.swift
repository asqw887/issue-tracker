//
//  Tag.swift
//  IssueTracker
//
//  Created by 최예주 on 2022/06/14.
//

import Foundation

final class Tag: Inform {

    let backgroundColor: UInt64
    init(title: String, backgroundColor: UInt64) {
        self.backgroundColor = backgroundColor
        super.init(title: title)
    }

}
