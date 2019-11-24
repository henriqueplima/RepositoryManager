//
//  Pull.swift
//  RepositoryManager
//
//  Created by Henrique Pereira de Lima on 23/11/19.
//  Copyright © 2019 Henrique Pereira de Lima. All rights reserved.
//

import Foundation

struct Pull: Codable {
    var state: State
    var title: String
    var body: String
    var user: Owner
    
    enum State: String, Codable {
        case Open = "open"
        case Closed = "closed"
    }
}
