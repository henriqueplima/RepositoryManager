//
//  RepositoryListWorker.swift
//  RepositoryManager
//
//  Created by Henrique Pereira de Lima on 23/11/19.
//  Copyright (c) 2019 Henrique Pereira de Lima. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol FetchPhoto {
    func fetchPhoto(path: String, complete: @escaping (ConnectorResult<Data>) -> Void)
}

protocol FetchRepositoryProtocol {
    func fetchRepositoryList<T:Decodable>(page: Int, complete:@escaping ((ConnectorResult<T>) -> Void))
}

class RepositoryListWorker: FetchRepositoryProtocol, FetchPhoto {
    func fetchRepositoryList<T: Decodable>(page: Int, complete: @escaping ((ConnectorResult<T>) -> Void)) {
        let endPoint = "search/repositories?q=language:Java&sort=stars&page=" + "\(page)"
        Connector.fetch(endPoint: endPoint, complete: complete)
    }
    
    func fetchPhoto(path: String, complete: @escaping (ConnectorResult<Data>) -> Void) {
        Connector.fetchData(path: path, complete: complete)
    }
}
