// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let results: Results
}

// MARK: - Results
struct Results: Codable {
    let shop: [Shop]

    enum CodingKeys: String, CodingKey {
        case shop
    }
}

// MARK: - Shop
struct Shop: Codable {
    let access: String?
    let lat, lng: Double?
    let name, nameKana: String?
    let photo: Photo
    let shopOpen: String?

    enum CodingKeys: String, CodingKey {
        case access
        case lat, lng
        case name
        case nameKana = "name_kana"
        case photo
        case shopOpen = "open"
    }
}

// MARK: - Photo
struct Photo: Codable {
    let pc: PC
}

// MARK: - PC
struct PC: Codable {
    let l: String?
}
