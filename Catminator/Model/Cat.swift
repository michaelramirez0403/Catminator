//
//  Cat.swift
//  Catminator
//
//  Created by Macky Ramirez on 10/2/24.
//

import UIKit
struct Cat: Hashable {
    var id: Int?
    var catdesc: String?
    var catUrl: String?
    var catImage: UIImage?
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
// MARK: - Cat Response
struct CatResponse: Codable, Hashable {
    var response: [String]?
    enum CodingKeys: String, CodingKey {
        case response = "data"
    }
}
