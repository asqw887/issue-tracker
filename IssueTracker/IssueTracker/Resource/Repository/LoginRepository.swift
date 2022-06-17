//
//  LoginRepository.swift
//  IssueTracker
//
//  Created by 최예주 on 2022/06/17.
//

import Foundation
import UIKit

class LoginRepository {

    func requestGithubAuthorize() {
        let clientID = "e6386d0321b6dc2820c0"
        let scope = "repo user"
        let urlString = "https://github.com/login/oauth/authorize"
        guard var components = URLComponents(string: urlString) else { return }
        components.queryItems = [
            URLQueryItem(name: "client_id", value: clientID),
            URLQueryItem(name: "scope", value: scope)
        ]
        guard let url = URL(string: "\(components.url!)"), UIApplication.shared.canOpenURL(url) else { return }

        UIApplication.shared.open(url)
    }

    func getGithubAccessCode(_ target: BaseTarget, _ completion: @escaping (String) -> Void) {

        guard let request = RequestRepository.makeURLRequest(with: target) else { return }
        RequestRepository.sendRequest(with: request) { data in
            guard let jsonData = try! JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }

            guard let access_token = jsonData["access_token"] as? String else { return }
            completion(access_token)
        }
    }

}