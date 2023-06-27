//
//  NewsModel.swift
//  News Aggregator
//
//  Created by Igor on 27.06.2023.
//

import Foundation

// MARK: - NewsModel
struct NewsModel: Decodable {
    let status: String
    let totalResults: Int
    let results: [UniqueNewsModel]
    let nextPage: String
}

// MARK: - Result
struct UniqueNewsModel: Decodable {
    let title: String
    let link: String
    let keywords: [String]?
    let creator: [String]?
    let videoURL: String?
    let description, content, pubDate: String
    let imageURL: String?
    let sourceID: String
    let category, country: [String]
    let language: String

    enum CodingKeys: String, CodingKey {
        case title, link, keywords, creator
        case videoURL = "video_url"
        case description, content, pubDate
        case imageURL = "image_url"
        case sourceID = "source_id"
        case category, country, language
    }
}
