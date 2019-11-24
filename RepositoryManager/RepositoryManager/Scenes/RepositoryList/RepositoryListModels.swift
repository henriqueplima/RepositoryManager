//
//  RepositoryListModels.swift
//  RepositoryManager
//
//  Created by Henrique Pereira de Lima on 23/11/19.
//  Copyright © 2019 Henrique Pereira de Lima. All rights reserved.
//

import Foundation
import UIKit

enum RepositoryListModels {
    struct ViewModel {
        var name: String
        var description: String
        var stars: String
        var forks: String
        var username: String
        var userFullName: String
        var photoPath: String
        var photo: UIImage?
    }
}
