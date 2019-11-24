//
//  PullListPresenter.swift
//  RepositoryManager
//
//  Created by Henrique Pereira de Lima on 23/11/19.
//  Copyright (c) 2019 Henrique Pereira de Lima. All rights reserved.
//


import UIKit

protocol PullListPresentationLogic {
    func presentPullList(list: [Pull])
    func presentAlert(title: String, message: String)
    func presentPhoto(data: Data, index: IndexPath)
}

class PullListPresenter: PullListPresentationLogic {
  
    weak var viewController: PullListDisplayLogic?
    
    func presentPullList(list: [Pull]) {
        
        let countOpen = list.filter { (pull) -> Bool in
            return pull.state == .Open
        }.count
        var countClosed = list.count - countOpen
        if countClosed < 0 {
            countClosed *= -1
        }
        
        let cellList = list.map { (pull) -> PullListModels.ViewModel.CellViewModel in
            return PullListModels.ViewModel.CellViewModel(title: pull.title, body: pull.body, userName: pull.user.login, type: pull.user.type, state: pull.state.rawValue, photo: nil)
        }
        
        let viewModel = PullListModels.ViewModel.Main(openAccount: "\(countOpen) opened ", closedAccount: "/ \(countClosed) closed", cellModelLits: cellList)
        viewController?.displayViewModel(viewModel)
    }
    
    func presentAlert(title: String, message: String) {
        viewController?.displayAlert(title: title, message: message)
    }
    
    func presentPhoto(data: Data, index: IndexPath) {
        guard let image = UIImage(data: data) else { return }
        viewController?.displayPhoto(index: index, photo: image)
    }
}
