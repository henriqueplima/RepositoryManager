//
//  RepositoryListRouter.swift
//  RepositoryManager
//
//  Created by Henrique Pereira de Lima on 23/11/19.
//  Copyright (c) 2019 Henrique Pereira de Lima. All rights reserved.
//

import UIKit

protocol RepositoryListRoutingLogic {
    func routeToPullList(rowSelected: Int)
}

protocol RepositoryListDataPassing {
  var dataStore: RepositoryListDataStore? { get }
}

class RepositoryListRouter: NSObject, RepositoryListRoutingLogic, RepositoryListDataPassing {
    
  weak var viewController: RepositoryListViewController?
  var dataStore: RepositoryListDataStore?
    
    func routeToPullList(rowSelected: Int) {
        guard let repoSelected = dataStore?.repositoryList[rowSelected] else { return }
        let nextController = PullListViewController(repository: repoSelected)
        viewController?.navigationController?.pushViewController(nextController, animated: true)
    }
  
}
