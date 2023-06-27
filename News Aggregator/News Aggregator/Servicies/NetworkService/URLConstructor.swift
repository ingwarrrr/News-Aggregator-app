//
//  URLConstructor.swift
//  News Aggregator
//
//  Created by Igor on 27.06.2023.
//

import Foundation

class URLConstructor {
    var service: Service
    var path: Path
    var queryItems: [URLQueryItem]?
    
    init(
        service: Service,
        path: Path,
        queryItems: [URLQueryItem]? = nil
    ) {
        self.service = service
        self.path = path
        self.queryItems = queryItems
    }
    
    func createURL() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.scheme
        urlComponents.host = Constants.host
        urlComponents.path = "\(service.rawValue)\(path.rawValue)"
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
}

extension URLConstructor {
    enum Service: String {
        case empty = ""
    }
    
    enum Path: String {
        case news = "/api/1/news"
    }
    
    enum Constants {
        static let scheme = "https"
        static let host = "newsdata.io"
    }
}
