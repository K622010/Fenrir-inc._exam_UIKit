//
//  URLRequestBuilder.swift
//  Pecori
//
//  Created by Rina Kurihara on 2022/08/15
//

import Foundation

struct URLRequestBuilder {
    
    func buildURLRequest<T: PecoriAPIRequest>(from request: T) -> URLRequest? {
        
        var urlComponents = URLComponents(
            url: request.baseURL.appendingPathComponent(request.path),
            resolvingAgainstBaseURL: false
        )
        
        urlComponents?.queryItems = request.queryParameters?.map { name, value in
            URLQueryItem(name: name, value: String(describing: value))
        }
        
        guard let url = urlComponents?.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue

        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(TokenManager.shared.token, forHTTPHeaderField: "X-PecoriToken")

        if let body = request.body {
            do {
                urlRequest.httpBody = try body.toData()
            } catch {
                return nil
            }
        }

        return urlRequest
    }
}
