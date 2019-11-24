//
//  PullListInteractor.swift
//  RepositoryManager
//
//  Created by Henrique Pereira de Lima on 23/11/19.
//  Copyright (c) 2019 Henrique Pereira de Lima. All rights reserved.
//


import UIKit

protocol PullListBusinessLogic {
    func fetchPulls()
    func fetchPhoto(index: IndexPath)
}

protocol PullListDataStore {
    var repository: GitRepository? { get set }
    var pullList: [Pull] { get set }
}

class PullListInteractor: PullListBusinessLogic, PullListDataStore {
    
    var presenter: PullListPresentationLogic?
    var worker: (FetchPulls & FetchPhoto)  = PullListWorker()
    var repository: GitRepository?
    var pullList: [Pull] = []
    
    func fetchPulls() {
        guard let repo = repository else { return }
        let request = PullListModels.Request(username: repo.owner.login, reponame: repo.name)
        worker.fetchPulls(request: request) { [weak self] (response: ConnectorResult<[Pull]>) in
            guard let self = self else { return }
            
            switch response {
            case .Success(let items):
                self.presenter?.presentPullList(list: items)
                self.pullList = items
            case .Failure(_):
                self.presenter?.presentAlert(title: "Erro", message: "Não foi possível trazer a lista de pulls")
            }
        }
    }
    
    func fetchPhoto(index: IndexPath) {
        let pull = pullList[index.row]
        worker.fetchPhoto(path: pull.user.avatarUrl) { [weak self] (response: ConnectorResult<Data>) in
            guard let self = self, response.isSuccess,let photoData = response.value else { return }
            self.presenter?.presentPhoto(data: photoData, index: index)
        }
    }
    
}
