//
//  PecoriRequestBody.swift
//  Pecori
//
//  Created by Rina Kurihara on 2022/08/15
//

import Foundation

struct PecoriRequestBody {
    let json: [String: Any?]
    init(json: [String: Any?]) {
        self.json = json
    }
    func toData() throws -> Data {
        return try JSONSerialization.data(withJSONObject: json)
    }
}
