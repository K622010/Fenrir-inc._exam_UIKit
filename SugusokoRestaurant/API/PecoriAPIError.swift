//
//  PecoriAPIError.swift
//  Pecori
//
//  Created by Rina Kurihara on 2022/08/15
//

import Foundation

struct PecoriAPIError: Codable, Hashable, Error {
    let code: String
    let description: String
}

struct PecoriAPIErrors: Codable, Hashable, Error {
    let errors: [PecoriAPIError]
}
