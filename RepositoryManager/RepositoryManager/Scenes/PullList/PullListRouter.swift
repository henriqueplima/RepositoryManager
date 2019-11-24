//
//  PullListRouter.swift
//  RepositoryManager
//
//  Created by Henrique Pereira de Lima on 23/11/19.
//  Copyright (c) 2019 Henrique Pereira de Lima. All rights reserved.
//

import UIKit

@objc protocol PullListRoutingLogic {

}

protocol PullListDataPassing {
  var dataStore: PullListDataStore? { get set }
}

class PullListRouter: NSObject, PullListRoutingLogic, PullListDataPassing {
    
  weak var viewController: PullListViewController?
  var dataStore: PullListDataStore?
  
}
