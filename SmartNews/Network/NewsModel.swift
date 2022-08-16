//
//  NewsModel.swift
//  SmartNews
//
//  Created by Вадим Лавор on 29.07.22.
//

import Foundation

struct Response: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let author: String?
    let title: String?
    let url: String?
    let urlToImage: String?
    let description: String?
    let content: String?
    let publishedAt: String?
}
