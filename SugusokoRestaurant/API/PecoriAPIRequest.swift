//
//  PecoriAPIRequest.swift
//  Pecori
//
//  Created by Rina Kurihara on 2022/08/15
//

import Foundation

enum HTTPMethod: String {
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    
}

protocol PecoriAPIRequest {

    associatedtype Response

    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryParameters: [String: Any]? { get }
    var body: PecoriRequestBody? { get }

    func parseResponse(from data: Data, httpURLResponse: HTTPURLResponse) throws -> Response
}

extension PecoriAPIRequest {

    var baseURL: URL {
        URL(string: "https://api.pecori.training.fdev2.net/api/v1")!
    }
}

extension PecoriAPIRequest where Response: Decodable {

    func parseResponse(from data: Data, httpURLResponse: HTTPURLResponse) throws -> Response {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Response.self, from: data)
    }
}
