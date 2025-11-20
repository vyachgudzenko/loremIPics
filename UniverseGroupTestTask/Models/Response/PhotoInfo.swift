//
//  PhotoInfo.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 19.11.2025.
//

import Foundation

struct PhotoInfo: Decodable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let downloadURL: String

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}
