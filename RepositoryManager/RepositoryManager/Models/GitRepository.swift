//
//  GitRepository.swift
//  RepositoryManager
//
//  Created by Henrique Pereira de Lima on 21/11/19.
//  Copyright © 2019 Henrique Pereira de Lima. All rights reserved.
//

import Foundation

struct GitRepository: Codable {
    var name: String
    var description: String
    var owner: Owner
    var stargazersCount: Int
    var forksCount : Int
}

struct RepositoryResponse : Decodable {
    var items : [GitRepository]
}

struct Owner: Codable {
    var login: String
    var avatarUrl: String
    var type: String
}
