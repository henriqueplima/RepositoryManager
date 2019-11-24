//
//  RepositoryListViewController.swift
//  RepositoryManager
//
//  Created by Henrique Pereira de Lima on 23/11/19.
//  Copyright (c) 2019 Henrique Pereira de Lima. All rights reserved.

import UIKit

protocol RepositoryListDisplayLogic: class {
    func displayRepositoryList(_ list: [RepositoryListModels.ViewModel])
    func displayPhoto(index: IndexPath, photo: UIImage)
    func displayAlert(message: String, title: String)
}

class RepositoryListViewController: UIViewController {
    var interactor: RepositoryListBusinessLogic?
    var router: (NSObjectProtocol & RepositoryListRoutingLogic & RepositoryListDataPassing)?
    var viewModelList: [RepositoryListModels.ViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var isFetchMore = false
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Object lifecycle
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
  
    private func setup() {
        let viewController = self
        let interactor = RepositoryListInteractor()
        let presenter = RepositoryListPresenter()
        let router = RepositoryListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
  
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        addSpinner()
        fetchList()
    }
    
    func fetchList() {
            interactor?.fetchList()
            isFetchMore = false
    }
    
    func addSpinner() {
        let spinner = UIActivityIndicatorView.init(style: .gray)
        spinner.startAnimating()
        spinner.frame = CGRect.init(x: 0, y: 0, width: self.tableView.frame.width, height: 44)
        self.tableView.tableFooterView = spinner
    }
}

extension RepositoryListViewController: RepositoryListDisplayLogic {
    func displayRepositoryList(_ list: [RepositoryListModels.ViewModel]) {
        viewModelList.append(contentsOf: list)
        isFetchMore = true
    }
    
    func displayPhoto(index: IndexPath, photo: UIImage) {
        viewModelList[index.row].photo = photo
        DispatchQueue.main.async {
            let cell = self.tableView.cellForRow(at: index) as? RepoTableCell
            cell?.setImage(image: photo)
        }
    }
    
    func displayAlert(message: String, title: String) {
        isFetchMore = true
        DispatchQueue.main.async {
            self.showAlert(title: title, message: message)
        }
    }
}

extension RepositoryListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func registerNibs(){
        tableView.register(UINib(nibName: String(describing: RepoTableCell.self), bundle: Bundle(for: RepoTableCell.self)), forCellReuseIdentifier: String(describing: RepoTableCell.self))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 133
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepoTableCell.self)) as? RepoTableCell  else { return UITableViewCell() }
            let cellViewModel = viewModelList[indexPath.row]
            if cellViewModel.photo == nil {
                interactor?.fetchPhoto(index: indexPath)
            }
            cell.setupCell(viewModel: viewModelList[indexPath.row], indexRow: indexPath.row)
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToPullList(rowSelected: indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if isFetchMore {
                fetchList()
            }
        }
    }
}

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
