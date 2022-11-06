//
//  LoginRequest.swift
//  Pecori
//
//  Created by 江越瑠一 on 2022/08/25.
//

import Foundation

struct LoginRequest {
    let ID: String
    let password: String
}

extension LoginRequest: PecoriAPIRequest {
    typealias Response = LoginResponse
    
    var method: HTTPMethod {
        .post
    }
    
    var path: String {
        return "/login"
    }
    
    var queryParameters: [String : Any]? {
        return [
            "userId": ID,
            "password": password
        ]
    }
    
    var body: PecoriRequestBody? {
        nil
    }
}
