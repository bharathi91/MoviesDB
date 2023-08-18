//
//  URLRequestGenerator.swift
//  MoviesDB
//
//  Created by Bharathi Kumar on 15/08/23.
//

import Foundation

protocol IURLRequestGenerator {
    func createURLRequest(serachString: String, using endPoint: INetworkRequest) throws -> URLRequest
}

class URLRequestGenerator: IURLRequestGenerator {
        
    func createURLRequest(serachString: String, using endPoint: INetworkRequest) throws -> URLRequest {
        do {
            let url = try createURL( serachString: serachString, with: endPoint)
            
            var urlRequest = URLRequest(url: url,
                                        cachePolicy: .useProtocolCachePolicy,
                                        timeoutInterval: 10.0)
    
            urlRequest.httpMethod = endPoint.method.rawValue
            
            if !endPoint.bodyParamaters.isEmpty {
                let bodyData = try? JSONSerialization.data(withJSONObject: endPoint.bodyParamaters, options: [.prettyPrinted])
                urlRequest.httpBody = bodyData
            }
           
           

            endPoint.headerParamaters.forEach({ key, value in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            })
            
            return urlRequest
        } catch {
            throw error
        }
    }
    
    private func createURL(serachString: String, with endPoint: INetworkRequest) throws -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Configuration.baseUrl + serachString + Configuration.api_key
        components.path = endPoint.path
        components.queryItems = endPoint.queryParameters.map {
            URLQueryItem(name: $0, value: "\($1)")
        }
        
        guard let url = URL(string: Configuration.baseUrl + serachString + Configuration.api_key) else {
            throw NSError(domain: "URL", code: NSURLErrorBadURL, userInfo: nil)
        }
//        guard let url = components.url else {
//            throw NSError(domain: "URL", code: NSURLErrorBadURL, userInfo: nil)
//        }
        return url

    }
}
