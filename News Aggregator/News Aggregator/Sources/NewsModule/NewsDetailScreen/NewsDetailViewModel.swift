//
//  NewsDetailViewModel.swift
//  News Aggregator
//
//  Created by Igor on 29.06.2023.
//

import Foundation

protocol NewsDetailViewModelType {
    var news: UniqueNewsModel { get set }
    
    func favourite()
    func unfavourite()
    func checkFavourite() -> Bool
}

class NewsDetailViewModel: NewsDetailViewModelType {
    var news: UniqueNewsModel

    init(news: UniqueNewsModel) {
        self.news = news
    }
    
    func favourite() {
        UserDefaultsManager.shared.newsArray.append(news)
    }

    func unfavourite(){
        UserDefaultsManager.shared.newsArray.removeAll(where: {
            $0.link == news.link
        })
    }
    
    func checkFavourite() -> Bool {
        UserDefaultsManager.shared.newsArray.contains(where: {
            $0.link == news.link
        })
    }
}
