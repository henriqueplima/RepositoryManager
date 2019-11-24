//
//  RepositoryListPresenter.swift
//  RepositoryManager
//
//  Created by Henrique Pereira de Lima on 23/11/19.
//  Copyright (c) 2019 Henrique Pereira de Lima. All rights reserved.
//


import UIKit

protocol RepositoryListPresentationLogic {
    func presentRepositoryList(_ list: [GitRepository])
    func presentPhoto(data: Data, index: IndexPath)
    func presentAlert(message: String, title: String)
}

class RepositoryListPresenter: RepositoryListPresentationLogic {
  
    weak var viewController: RepositoryListDisplayLogic?
    func presentRepositoryList(_ list: [GitRepository]) {
        
      let listModel =  list.map { (repository) -> RepositoryListModels.ViewModel in
        return RepositoryListModels.ViewModel(name: repository.name, description: repository.description, stars: "\(repository.stargazersCount)", forks: "\(repository.forksCount)", username: repository.owner.login, userFullName: repository.owner.type, photoPath: repository.owner.avatarUrl, photo: nil)
        }
        viewController?.displayRepositoryList(listModel)
    }
    
    func presentPhoto(data: Data, index: IndexPath) {
        guard let image = UIImage(data: data) else { return }
        viewController?.displayPhoto(index: index, photo: image)
    }
    
    func presentAlert(message: String, title: String) {
        viewController?.displayAlert(message: message, title: title)
    }

}
