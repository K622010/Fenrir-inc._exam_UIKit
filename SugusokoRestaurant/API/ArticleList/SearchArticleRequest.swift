//
//  SearchArticleRequest.swift
//  Pecori
//
//  Created by Rina Kurihara on 2022/08/15
//

import Foundation

struct SearchArticleRequest {
    
    let query: String?
    let contributorId: String?
    let offset: Int?
    let limit: Int?
    let isLiked: Bool?
    
    init(query: String? = nil, contributorId: String? = nil, offset: Int? = nil, limit: Int? = nil, isLiked: Bool? = nil) {
        
        self.query = query
        self.contributorId = contributorId
        self.offset = offset
        self.limit = limit
        self.isLiked = isLiked
        
    }
}

extension SearchArticleRequest: PecoriAPIRequest {
    
    typealias Response = ArticleListResponse
    
    var method: HTTPMethod {
        .get
    }
    
    var path: String {
        "/articles"
    }
    
    var queryParameters: [String: Any]? {
        
        let items: [String: Any?] = [
            
            "query": query,
            "contributorId": contributorId,
            "offset": offset,
            "limit": limit,
            "isLiked": isLiked
            
        ]
        
        return items.compactMapValues { $0 }
        
    }
    
    var body: PecoriRequestBody? {
        nil
    }

}
