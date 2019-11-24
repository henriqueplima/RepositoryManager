//
//  RepositoryListViewController.swift
//  RepositoryManagerTests
//
//  Created by Henrique Pereira de Lima on 24/11/19.
//  Copyright © 2019 Henrique Pereira de Lima. All rights reserved.
//

import XCTest
@testable import RepositoryManager

class RepositoryListViewControllerTest: XCTestCase {
    
   var sut: RepositoryListViewController!

    override func setUp() {
        super.setUp()
        setupTest()
    }

    override func tearDown() {
        super.tearDown()
        tearDownTest()
    }
    
    // MARK: setUp
    func setupTest() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: RepositoryListViewController.self)) as? RepositoryListViewController
    }

    // MARK: teardDown
    func tearDownTest() {
        sut = nil
    }
    
    func testFetchList() {
        let interactor = sut.interactor as! RepositoryListInteractor
        interactor.worker = RepositoryWorkerMock()
        
        _ = sut.view
        sut.tableView.reloadData()
        let cell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! RepoTableCell
        
        XCTAssertEqual(sut.viewModelList.count, 3)
        XCTAssertEqual(cell.repoNameLabel.text, "gson")
        XCTAssertEqual(cell.descriptionLabel.text, "A Java serialization")
        XCTAssertEqual(cell.starsLabel.text, "16865")
        XCTAssertEqual(cell.forkLabel.text, "3339")
        XCTAssertEqual(cell.fullNameLabel.text, "Organization")
        XCTAssertEqual(cell.usernameLabel.text, "google")
        XCTAssertNil(cell.imageView?.image)
        
    }
    
    func testFetchListMore() {
        let interactor = sut.interactor as! RepositoryListInteractor
        interactor.worker = RepositoryWorkerMock()
        _ = sut.view
        sut.fetchList()
        XCTAssertEqual(sut.viewModelList.count, 6)
    }
    
    func testFetchImage() {
        let interactor = sut.interactor as! RepositoryListInteractor
        interactor.worker = RepositoryWorkerMock()
        let index = IndexPath(row: 0, section: 0)
        
        _ = sut.view
        sut.tableView.reloadData()
        sut.interactor?.fetchPhoto(index: index)
        let model = sut.viewModelList[index.row]
        
        XCTAssertNotNil(model.photo)
    }
    
    func testErrorFlow() {
        let interactor = sut.interactor as! RepositoryListInteractor
        let presenterMock = RepositoryPresentationLogicMock()
        presenterMock.viewController = sut
        interactor.worker = RepositoryWorkerFailureMock()
        interactor.presenter = presenterMock
        
        _ = sut.view
        XCTAssertEqual(presenterMock.message, "Não foi possível buscar mais repositórios")
        XCTAssertEqual(presenterMock.title, "Erro")
    }

    // MARK: MOCKS
    
    class RepositoryWorkerMock: FetchPhoto, FetchRepositoryProtocol {
        func fetchPhoto(path: String, complete: @escaping (ConnectorResult<Data>) -> Void) {
            let image = UIImage(named: "stars")
            let data = image?.pngData()
            complete(.Success(data!))
        }
        
        func fetchRepositoryList<T>(page: Int, complete: @escaping ((ConnectorResult<T>) -> Void)) where T : Decodable {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let parse = try! decoder.decode(T.self, from: Mocks.Repository.mock)
            complete(.Success(parse))
        }
    }
    
    class RepositoryWorkerFailureMock: FetchPhoto, FetchRepositoryProtocol {
        func fetchPhoto(path: String, complete: @escaping (ConnectorResult<Data>) -> Void) {
            complete(.Failure(nil))
        }
        
        func fetchRepositoryList<T>(page: Int, complete: @escaping ((ConnectorResult<T>) -> Void)) where T : Decodable {
            complete(.Failure(nil))
        }
    }
    
    class RepositoryPresentationLogicMock: RepositoryListPresentationLogic {
        
        var message = ""
        var title = ""
        weak var viewController: RepositoryListDisplayLogic?
        
        func presentRepositoryList(_ list: [GitRepository]) { }
        
        func presentPhoto(data: Data, index: IndexPath) { }
        
        func presentAlert(message: String, title: String) {
            self.message = message
            self.title = title
        }
    }

}
