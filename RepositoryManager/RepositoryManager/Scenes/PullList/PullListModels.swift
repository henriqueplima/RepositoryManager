//
//  PullListModels.swift
//  RepositoryManager
//
//  Created by Henrique Pereira de Lima on 23/11/19.
//  Copyright © 2019 Henrique Pereira de Lima. All rights reserved.
//

import Foundation
import UIKit

enum PullListModels {
    struct Request {
        var username: String
        var reponame: String
        var state: String = "all"
        
        init(username: String, reponame: String) {
            self.username = username
            self.reponame = reponame
        }
    }
    
    enum ViewModel {
        
        struct Main {
            var openAccount: String
            var closedAccount: String
            var cellModelLits: [CellViewModel]
        }
        
        struct CellViewModel {
            var title: String
            var body: String
            var userName: String
            var type: String
            var state: String
            var photo: UIImage?
        }
        
    }
}
