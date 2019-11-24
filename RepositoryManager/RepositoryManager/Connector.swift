//
//  Connector.swift
//  RepositoryManager
//
//  Created by Henrique Pereira de Lima on 21/11/19.
//  Copyright © 2019 Henrique Pereira de Lima. All rights reserved.
//

import Foundation



class Connector {
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30.0
        return config
    }()
    private static let configuration2: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 5.0
        return config
    }()
    
    private static let session = URLSession(configuration: configuration)
    private static let sessionData = URLSession(configuration: configuration2)
    
    private static let baseUrl = "https://api.github.com/"
    
    static func fetch<T:Decodable>(endPoint: String, complete: @escaping ((ConnectorResult<T>) -> Void) ) {
        
        guard let url = URL(string: baseUrl + endPoint) else {
            complete(.Failure(nil))
            return
        }
        
        session.dataTask(with: url) { (response, _, error) in

            guard let data = response else {
                complete(.Failure(nil))
                return
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            do {
                let codingData = try decoder.decode(T.self, from: data)
                complete(.Success(codingData))
            } catch {
                complete(.Failure(nil))
            }
        }.resume()
    }
    
    static func fetchData(path: String, complete: @escaping (ConnectorResult<Data>) -> Void) {
        guard let url = URL(string: path) else {
            complete(.Failure(nil))
            return
        }
        sessionData.dataTask(with: url) { (response, _, error) in
            guard let data = response, error == nil else {
                complete(.Failure(nil))
                return
            }
            complete(.Success(data))
        }.resume()
    }
}

enum ConnectorResult<T>{
    case Success(T)
    case Failure(_ error: String?)
    
    var isSuccess : Bool {
        switch self {
        case .Success:
            return true
        case .Failure:
            return false
        }
    }
    
    var value : T? {
        switch self {
        case .Success(let value):
            return value
        case .Failure:
            return nil
        }
    }
    
    var error : String? {
        switch self {
        case .Success:
            return nil
        case .Failure(let error):
            return error
        }
    }
}
