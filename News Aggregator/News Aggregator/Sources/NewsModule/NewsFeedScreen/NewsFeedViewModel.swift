//
//  NewsFeedViewModel.swift
//  News Aggregator
//
//  Created by Igor on 27.06.2023.
//

import Foundation

protocol NewsFeedViewModelType {
    var newsModel: [NewsModel]? { get set }
    var newsArray: [UniqueNewsModel]? { get set }

    var getNewsSuccess: ((NewsModel) -> Void)? { get set }
    var getNewsFailure: ((Error) -> Void)? { get set }
    
    func getNewsData(for nextPage: String?)
}

final class NewsFeedViewModel: NewsFeedViewModelType {
    
    var getNewsSuccess: ((NewsModel) -> Void)?
    var getNewsFailure: ((Error) -> Void)?
    
    var newsModel: [NewsModel]? = []
    var newsArray: [UniqueNewsModel]? = []
    let networknigApi: NetworkingAPIProtocol
    
    init() {
        networknigApi = NetworkingAPI()
    }
    
    public func getNewsData(for nextPage: String?) {
        networknigApi.getNewsFor(nextPage: nextPage) { [weak self] response in
            switch response {
            case .success(let response):
                print(response)
                self?.newsModel?.append(response)
                self?.newsArray?.append(contentsOf: response.results)
                self?.getNewsSuccess?(response)
            case .failure(let error):
                self?.getNewsFailure?(error)
            }
        }
    }
}
