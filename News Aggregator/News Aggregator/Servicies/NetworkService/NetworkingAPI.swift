//
//  NetworkingAPI.swift
//  News Aggregator
//
//  Created by Igor on 27.06.2023.
//

import Foundation
import Alamofire

protocol NetworkingAPIProtocol {
    func getNewsFor(
        nextPage: String?,
        completion: @escaping (Result<NewsModel, Error>) -> Void
    )
}

final class NetworkingAPI: NetworkingAPIProtocol {
    
    // MARK: - Get News Methods
    
    func getNewsFor(
        nextPage: String?,
        completion: @escaping (Result<NewsModel, Error>) -> Void
    ) {
        var queryItems = [
            URLQueryItem(
                name: QueryItems.apiKeyName, value: QueryItems.apiKeyVal
            ),
            URLQueryItem(
                name: QueryItems.countryName, value: QueryItems.countryVal
            )
        ]
        if let nextPage = nextPage {
            queryItems.append(
                URLQueryItem(name: QueryItems.nextPageName, value: nextPage)
            )
        }
        
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

fileprivate enum QueryItems {
    static let apiKeyName = "apikey"
    static let countryName = "country"
    static let nextPageName = "page"
    static let apiKeyVal = "pub_25236fe42fb232801f31994435c36828de93a"
    static let countryVal = "ru"
}
