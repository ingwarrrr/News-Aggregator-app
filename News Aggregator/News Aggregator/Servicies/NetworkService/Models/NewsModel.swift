//
//  NewsModel.swift
//  News Aggregator
//
//  Created by Igor on 27.06.2023.
//

import Foundation

// MARK: - NewsModel
struct NewsModel: Codable {
    let status: String?
    let totalResults: Int?
    var results: [UniqueNewsModel]
    let nextPage: String?
}

// MARK: - Result
struct UniqueNewsModel: Codable {
    let title: String?
    let link: String?
    let keywords: [String]?
    let creator: [String]?
    let videoURL: String?
    let description: String?
    let content: String?
    let pubDate: String?
    let imageURL: String?
    var imageData: Data? = nil
    let sourceID: String?
    let category: [String]?
    let country: [String]?
    let language: String?

    enum CodingKeys: String, CodingKey {
        case title, link, keywords, creator
        case videoURL = "video_url"
        case description, content, pubDate
        case imageURL = "image_url"
        case sourceID = "source_id"
        case category, country, language
    }
}
