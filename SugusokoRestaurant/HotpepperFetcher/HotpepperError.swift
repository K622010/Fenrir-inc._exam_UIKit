//
//  HotpepperError.swift
//  SugusokoRestaurant
//
//  Created by 江越瑠一 on 2022/11/05.
//

import Foundation

enum HotpepperError: Error {
    case parsing(description: String)
    case network(description: String)
}

