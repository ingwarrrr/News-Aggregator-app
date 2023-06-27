//
//  NetworkingAPI.swift
//  News Aggregator
//
//  Created by Igor on 27.06.2023.
//

import Foundation
import Alamofire

protocol NetworkingAPIProtocol {
    func getNews(completion: @escaping (Result<NewsModel, Error>) -> Void)
}

class NetworkingAPI: NetworkingAPIProtocol {
    
    // MARK: - Get News Methods
    
    func getNews(completion: @escaping (Result<NewsModel, Error>) -> Void) {
        let queryItems = [
            URLQueryItem(name: "apikey", value: "pub_25236fe42fb232801f31994435c36828de93a"),
            URLQueryItem(name: "q", value: "pizza")
        ]
        
        let urlConstructor = URLConstructor(
            service: .empty,
            path: .news,
            queryItems: queryItems
        )
        guard let url = urlConstructor.createURL() else { return }
        
        AF.request(url)
            .responseDecodable(of: NewsModel.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
