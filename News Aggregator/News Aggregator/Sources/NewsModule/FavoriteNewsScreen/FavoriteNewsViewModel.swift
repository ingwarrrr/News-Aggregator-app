//
//  FavoriteNewsViewModel.swift
//  News Aggregator
//
//  Created by Igor on 29.06.2023.
//

import Foundation

protocol FavoriteNewsViewModelType {
    var favNewsArray: [UniqueNewsModel] { get }
}

class FavoriteNewsViewModel: FavoriteNewsViewModelType {
    var favNewsArray: [UniqueNewsModel] {
        UserDefaultsManager.shared.newsArray
    }
}
