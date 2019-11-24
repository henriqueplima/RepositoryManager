//
//  RepositoryListInteractor.swift
//  RepositoryManager
//
//  Created by Henrique Pereira de Lima on 23/11/19.
//  Copyright (c) 2019 Henrique Pereira de Lima. All rights reserved.
//


import UIKit

protocol RepositoryListBusinessLogic {
    func fetchList()
    func fetchPhoto(index: IndexPath)
}

protocol RepositoryListDataStore {
    var repositoryList: [GitRepository] { get set }
}

class RepositoryListInteractor: RepositoryListBusinessLogic, RepositoryListDataStore {
    
    var presenter: RepositoryListPresentationLogic?
    var worker: (FetchRepositoryProtocol & FetchPhoto) = RepositoryListWorker()
    var repositoryList: [GitRepository] = []
    var currentPage: Int = 1
    let messageError = "Não foi possível buscar mais repositórios"
    let titleError = "Erro"
    
    func fetchList() {
        worker.fetchRepositoryList(page: currentPage) { [weak self] (response: ConnectorResult<RepositoryResponse>) in
            guard let self = self else { return }
            switch response{
            case .Success(let value):
                if !value.items.isEmpty {
                    self.repositoryList.append(contentsOf: value.items)
                    self.currentPage += 1
                    self.presenter?.presentRepositoryList(value.items)
                } else {
                    self.presenter?.presentAlert(message: self.messageError, title: self.titleError)
                }
            case .Failure(_):
                self.presenter?.presentAlert(message: self.messageError, title: self.titleError)
            }
        }
    }
    
    func fetchPhoto(index: IndexPath) {
        let repository = repositoryList[index.row]
        worker.fetchPhoto(path: repository.owner.avatarUrl) { [weak self] (response: ConnectorResult<Data>) in
            guard let self = self, response.isSuccess,let photoData = response.value else { return }
            self.presenter?.presentPhoto(data: photoData, index: index)
        }
    }
}
