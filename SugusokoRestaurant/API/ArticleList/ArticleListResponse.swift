//
//  ArticleListResponse.swift
//  Pecori
//
//  Created by Rina Kurihara on 2022/08/15
//

import Foundation

struct ArticleListResponse: Codable, Hashable {
    
    var articles: [Article]
    
}

struct Contributor: Codable, Hashable {
    
    let id: String
    let nickname: String
    let introduction: String
    let imageURL: URL?
    
}

struct Article: Codable, Hashable {
    
    let id: Int
    let createdDate: Int
    let comment: String
    let contributor: Contributor
    let thumbnailImageURL: URL
    var isLiked: Bool
    
}
