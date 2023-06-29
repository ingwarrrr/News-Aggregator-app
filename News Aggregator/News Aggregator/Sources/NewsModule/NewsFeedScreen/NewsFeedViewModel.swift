//
//  NewsFeedViewModel.swift
//  News Aggregator
//
//  Created by Igor on 27.06.2023.
//

import Foundation

protocol NewsFeedViewModelType {
    var newsArray: NewsModel? { get set }
    
    var getNewsSuccess: ((NewsModel) -> Void)? { get set }
    var getNewsFailure: ((Error) -> Void)? { get set }
    
    func getNewsData()
}

class NewsFeedViewModel: NewsFeedViewModelType {
    
    var getNewsSuccess: ((NewsModel) -> Void)?
    var getNewsFailure: ((Error) -> Void)?
    var newsArray: NewsModel?
    let networknigApi: NetworkingAPIProtocol
    
    init() {
        networknigApi = NetworkingAPI()
    }

    public func getNewsData() {
        networknigApi.getNews { [weak self] response in
            switch response {
            case .success(let response):
                self?.newsArray = response
                self?.getNewsSuccess?(response)
            case .failure(let error):
                self?.getNewsFailure?(error)
            }
        }
    }
    
    public func getImageData() {
        networknigApi.getNews { [weak self] response in
            switch response {
            case .success(let response):
                self?.newsArray = response
                self?.getNewsSuccess?(response)
            case .failure(let error):
                self?.getNewsFailure?(error)
            }
        }
    }
}
