//
//  NetworkManager.swift
//  MoviesDB
//
//  Created by Bharathi Kumar on 15/08/23.
//

import Foundation

typealias Response<T: Decodable> = (Result<T, Error>) -> Void

protocol INetworkManager {
    func request<T: Decodable>(searchString: String,request: INetworkRequest, completion: @escaping Response<T>)
}

class NetworkManager: NSObject, INetworkManager {
    
    private let session: URLSession
    private let requestGenerator: IURLRequestGenerator
    
    static let initObject: INetworkManager = {
            let networkManager = NetworkManager()
            return networkManager
        }()
    
    init(session: URLSession, requestGenerator: IURLRequestGenerator) {
        self.session = session
        self.requestGenerator = requestGenerator
    }
    
    convenience init(session: URLSession = .shared) {
        self.init(session: session, requestGenerator: URLRequestGenerator())
    }
    
    func request<T: Decodable>(searchString: String,request: INetworkRequest, completion: @escaping Response<T>) {
        var request1 = request
        //request1.bodyParamaters = ["api_key": "c8cf4b259fb6aed1e8562a005b7f6d8c"]
        guard var urlRequest = try? requestGenerator.createURLRequest(serachString: searchString, using: request1) else {
            return completion(.failure(NetworkError.invalidRequest))
        }
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            let str = String(decoding: data!, as: UTF8.self)
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data!, options : .mutableContainers) as? [Dictionary<String,Any>]
                {
                   print(jsonArray) // use the json here
                } else {
                    print("bad json")
                }
            } catch let error as NSError {
                print(error)
            }
            if error != nil {
                return completion(.failure(NetworkError.badRequest))
            }
            
            guard let urlResponse = response as? HTTPURLResponse else {
                return completion(.failure(NetworkError.noResponse))
            }
            
            if urlResponse.statusCode != 200 {
                return completion(.failure(NetworkError.failed))
            }
            
            guard let data = data else {
                return completion(.failure(NetworkError.noData))
            }
            
            do {
                let str = String(decoding: data, as: UTF8.self)
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(NetworkError.unableToDecode))
            }
        }
        task.resume()
    }
}
