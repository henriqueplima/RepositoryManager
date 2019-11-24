//
//  PullListViewController.swift
//  RepositoryManager
//
//  Created by Henrique Pereira de Lima on 23/11/19.
//  Copyright (c) 2019 Henrique Pereira de Lima. All rights reserved.

import UIKit

protocol PullListDisplayLogic: class {
    func displayViewModel(_ viewModel: PullListModels.ViewModel.Main)
    func displayAlert(title: String, message: String)
    func displayPhoto(index: IndexPath, photo: UIImage)
}

class PullListViewController: UIViewController {
    var interactor: PullListBusinessLogic?
    var router: (NSObjectProtocol & PullListRoutingLogic & PullListDataPassing)?
    var navigationTitle: String = ""
    var viewModel: PullListModels.ViewModel.Main? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.removeSpinner()
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Object lifecycle
    convenience init(repository: GitRepository) {
        self.init(nibName: nil, bundle: nil)
        router?.dataStore?.repository = repository
        navigationTitle = repository.name
    }
  
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: String(describing: PullListViewController.self), bundle: Bundle(for: PullListViewController.self))
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
  
    private func setup() {
        let viewController = self
        let interactor = PullListInteractor()
        let presenter = PullListPresenter()
        let router = PullListRouter()
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
        setupView()
        interactor?.fetchPulls()
    }
    
    func setupView() {
         title = navigationTitle
        registerNibs()
        addSpinner()
    }
    
    func addSpinner() {
        let spinner = UIActivityIndicatorView.init(style: .gray)
        spinner.startAnimating()
        spinner.frame = CGRect.init(x: 0, y: 0, width: self.tableView.frame.width, height: 44)
        self.tableView.tableFooterView = spinner
    }
    
    func removeSpinner() {
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

extension PullListViewController: PullListDisplayLogic {
    func displayViewModel(_ viewModel: PullListModels.ViewModel.Main) {
        self.viewModel = viewModel
    }
    
    func displayAlert(title: String, message: String) {
        DispatchQueue.main.async {
            self.showAlert(title: title, message: message)
            self.removeSpinner()
        }
    }
    
    func displayPhoto(index: IndexPath, photo: UIImage) {
        viewModel?.cellModelLits[index.row].photo = photo
        DispatchQueue.main.async {
            let cell = self.tableView.cellForRow(at: index) as? PullTableCell
            cell?.setImage(image: photo)
        }
    }
}

extension PullListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func registerNibs() {
        tableView.register(UINib(nibName: String(describing: PullTableCell.self), bundle: Bundle(for: PullTableCell.self)), forCellReuseIdentifier: String(describing: PullTableCell.self))
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = HeaderSeaction().loadNib() as? HeaderSeaction
        view?.titleLabel.attributedText =  NSMutableAttributedString().changeColor(viewModel?.openAccount ?? "", color: UIColor.orange).changeColor(viewModel?.closedAccount ?? "", color: UIColor.black)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellModelLits.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PullTableCell.self)) as? PullTableCell, let model = viewModel?.cellModelLits[indexPath.row] else { return UITableViewCell () }
        if model.photo == nil {
            interactor?.fetchPhoto(index: indexPath)
        }
        cell.setupViewModel(viewModel: model)
        return cell
    }
}
