//
//  PecoriAPIClient.swift
//  Pecori
//
//  Created by Rina Kurihara on 2022/08/15
//

import Foundation

enum HTTPError: Error {

    case parseError
    case invalidResponse
    case invalidRequest
    case pecoriAPIError(PecoriAPIErrors)
    case offline
    case unknownError
    case expiredToken
    
}

struct PecoriAPIClient {
    
    private let urlSession: URLSession
    private let urlRequestBuilder: URLRequestBuilder

    init(urlSession: URLSession, urlRequestBuilder: URLRequestBuilder) {
        self.urlSession = urlSession
        self.urlRequestBuilder = urlRequestBuilder
    }

    @discardableResult
    func send<Request: PecoriAPIRequest>(
        _ request: Request,
        _ handler: @escaping (Result<Request.Response, HTTPError>) -> Void
    ) -> URLSessionTask? {
            
        guard let urlRequest = urlRequestBuilder.buildURLRequest(from: request) else {
            handler(.failure(.invalidRequest))
            return nil
        }
        
        debugRequest(urlRequest)
        
        let task = urlSession.dataTask(with: urlRequest) { data, urlResponse, error in
            
            DispatchQueue.main.async {
                
                debugResponse(urlResponse as! HTTPURLResponse, data: data!)
                
                switch (data, urlResponse, error) {
                    
                case (.some(let data), .some(let httpURLResponse as HTTPURLResponse), nil):
                    
                    do {
                        switch httpURLResponse.statusCode {
                            
                        case 200:
                            let token = try request.parseResponse(from: data, httpURLResponse: httpURLResponse)
                            handler(.success(token))
                            
                        case 400:
                            let pecoriAPIError = try JSONDecoder().decode(PecoriAPIErrors.self, from: data)
                            handler(.failure(.pecoriAPIError(pecoriAPIError)))
                            
                        case 401:
                            handler(.failure(.expiredToken))
                            
                        case 500:
                            handler(.failure(.unknownError))
                            
                        default:
                            handler(.failure(.unknownError))
                            
                        }
                        
                    } catch {
                        
                        handler(.failure(.parseError))
                    }
                    
                case (nil, _, .some(let error)):
                    
                    print(error.localizedDescription)
                    handler(.failure(.invalidResponse))
                    
                default:
                    fatalError()
                }
            }
        }
        
        task.resume()
        return task
        
    }
}

private extension PecoriAPIClient {
    
    func debugResponse(_ response: HTTPURLResponse, data: Data) {
        
        #if DEBUG
        
        let body: String
        
        do {
            
            let json = try JSONSerialization.jsonObject(with: data)
            let prettyData = try JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted])
            body = String(data: prettyData, encoding: .utf8) ?? "nil"
            
        } catch {
            
            print("\(error)")
            body = "nil"
            
        }
        
        var output: [String] = []
        
        output.append("=========== HTTP RESPONSE ===========")
        output.append("[Response]: \(response.url!)") // original url request
        output.append("[Status Code]: \(response.statusCode)")
        output.append("[Header]: \(response.allHeaderFields as! [String: String])")
        output.append("[Body]: \(body)")
        
        let outputString = output.joined(separator: "\n")
        
        print(outputString)
        
        #endif
    }
    
    func debugRequest(_ url: URLRequest) {
        
        #if DEBUG
        
        var output: [String] = []
        
        output.append("=========== HTTP REQUEST ===========")
        output.append("[Request]: \(url.httpMethod!) \(url.url!)")
        output.append("[Header]: \(url.allHTTPHeaderFields!)")
        if let body = url.httpBody {
            output.append("[Body]: \(String(data: body, encoding: String.Encoding.utf8) ?? "")")
        }
        
        let outputString = output.joined(separator: "\n")
        
        print(outputString)
        
        #endif
    }
}
